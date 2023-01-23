from flask import Flask, render_template, url_for, request, redirect, session
from werkzeug.security import generate_password_hash, check_password_hash

import mysql.connector
import mariadb
import ast 

konekcija = mysql.connector.connect(
    passwd = "", #lozinka za bazu
    user = "root", #korisnicko ime
    database = "nekretnine", #ime baze
    port = 3306 , #port msql servera 
    auth_plugin = 'mysql_native_password'
)

kursor = konekcija.cursor(dictionary=True)
app = Flask (__name__)  
app.secret_key = "tajni_kljuc_aplikacije"

def auth():
    if "ulogovani_korisnik" in session:
        return True
    else:
        return False    

def role():
    if auth():
        return ast.literal_eval(session["ulogovani_korisnik"]).pop("role")

def isAdmin():
    if auth():
        return role() == 'admin'     

app.jinja_env.globals.update(role=role)
########################## Logika za Auth  #############################
#######################################################
@app.route('/login', methods=['GET','POST'])
def render_login():
    session.clear()
    if request.method == 'GET':
        return render_template('login.html')
    if request.method == 'POST':
        forma = request.form
        upit = "SELECT * FROM korisnici WHERE email=%s"
        vrednost = (forma["email"],)
        kursor.execute(upit, vrednost)
        korisnik = kursor.fetchone()

        if korisnik != None:
            # OVO VRACA FALSE A NE TREBA
            if check_password_hash(korisnik["password"], forma["password"]):
                session ["ulogovani_korisnik"] = str(korisnik)
                return redirect(url_for('render_stanovi'))
            else:
                return render_template("login.html")
        else:
                return render_template("login.html")

@app.route('/logout')
def logout():
    session.pop('ulogovani_korisnik',None)
    return redirect(url_for('render_login'))
##############################################################################

########################## Logika za Korisnike  #############################
##############################################################################
@app.route('/korisnici', methods=['GET'])
def render_korisnici():
    if auth() and isAdmin():
        upit = "select * from korisnici"
        kursor.execute(upit)
        korisnici = kursor.fetchall()
        return render_template('korisnici.html', korisnici = korisnici)

@app.route('/korisnik_novi', methods=['GET', 'POST'])
def korisnik_novi():
    if auth() and isAdmin():
        if request.method == "GET":
            return render_template('korisnik_novi.html')

        if request.method == "POST":
            forma = request.form
            hashPass = generate_password_hash(forma["password"])
            vrednosti = (
                forma["first_name"],
                forma["last_name"],
                forma["email"],
                forma["role"],
                hashPass
            )

            upit = """insert into 
                        korisnici(first_name, last_name, email, role, password)
                        values (%s, %s, %s, %s, %s)  
            """

            kursor.execute(upit, vrednosti)
            konekcija.commit()  

            return redirect(url_for("render_korisnici"))

@app.route('/korisnik_izmena/<id>', methods=["GET", "POST"])
def korisnik_izmena(id):
    if auth() and isAdmin():
        tempID = int(id)
        if request.method == "GET":
            upit="select * from korisnici where id=%s"
            vrednost = (tempID, )
            kursor.execute(upit, vrednost)
            korisnik = kursor.fetchone()

            return render_template("korisnik_izmena.html", korisnik=korisnik)

        if request.method == "POST":
            upit = """update korisnici set 
                        first_name  = %s, last_name = %s, email = %s, role = %s, password = %s
                        where id = %s
            """
            forma = request.form
            hashPass = generate_password_hash(forma["password"])
            vrednosti = (
                forma["first_name"],
                forma["last_name"],
                forma["email"],
                forma["role"],
                hashPass,
                tempID
            )
            kursor.execute(upit, vrednosti)
            konekcija.commit()
            return redirect(url_for('render_korisnici'))

@app.route('/korisnik_brisanje/<id>', methods=["POST"])
def korisnik_brisanje(id):
    if auth() and isAdmin():
        upit = """
                DELETE FROM korisnici WHERE id=%s
        """
        vrednost = (int(id), )
        kursor.execute(upit, vrednost)
        konekcija.commit()
        return redirect(url_for("render_korisnici"))
##############################################################################

########################## Logika za Stanove  #############################
##############################################################################
### GET ALL STANOVI
@app.route('/stanovi', methods=['GET'])
def render_stanovi():
    if auth():
        upit = "select * from stanovi"
        kursor.execute(upit)
        stanovi = kursor.fetchall()
        return render_template('stanovi.html', stanovi = stanovi)

### GET STAN BY ID
@app.route('/stan/<id>', methods=['GET'])
def render_stan_by_id(id):
    if auth():
        upit="select * from stanovi where id=%s"
        vrednost = (int(id),)
        kursor.execute(upit, vrednost)
        stan = kursor.fetchone()
        return render_template('stan.html', stan = stan)

### UPDATE STAN BY ID
@app.route('/update_stan/<id>', methods=["GET","POST"])      
def update_stan(id):
    if auth() and isAdmin():
        tempID = int(id)
        if request.method == "GET":
            upit="select * from stanovi where id=%s"
            vrednost = (tempID, )
            kursor.execute(upit, vrednost)
            stan = kursor.fetchone()
            return render_template("update_stan.html", stan=stan)

        if request.method == "POST":
            upit = """update stanovi set cena  = %s, adresa = %s, kvadratura = %s, cena_po_kvadratu = %s, oglasavac = %s, slika = %s, broj_soba = %s where id=%s"""

            forma = request.form
            vrednosti = (
                forma["cena"],
                forma["adresa"],
                forma["kvadratura"],
                forma["cena_po_kvadratu"],
                forma["oglasavac"],
                forma["slika"],
                forma["broj_soba"],
                tempID
            )
            kursor.execute(upit, vrednosti)
            konekcija.commit()
            return redirect(url_for('render_stanovi'))

### ADD STAN BY ID
@app.route('/add_stan', methods=["GET","POST"])      
def add_stan():
    if auth() and isAdmin():
        if request.method == "GET":
            return render_template("add_stan.html")
        if request.method == "POST":
            forma = request.form
            vrednosti = (
                    forma["cena"],
                    forma["adresa"],
                    forma["kvadratura"],
                    forma["cena_po_kvadratu"],
                    forma["oglasavac"],
                    forma["slika"],
                    forma["broj_soba"],
            )
            upit = "insert into stanovi(cena,adresa,kvadratura,cena_po_kvadratu,oglasavac,slika,broj_soba) values (%s, %s, %s, %s, %s, %s, %s)"
            kursor.execute(upit, vrednosti)
            konekcija.commit()  
            return redirect(url_for("render_stanovi"))        

### DELETE STAN BY ID
@app.route('/delete_stan_by_id/<id>', methods=["POST"])
def delete_stan_by_id(id):
    if auth() and isAdmin():
        upit="delete from stanovi where id=%s"
        vrednost = (int(id), )
        kursor.execute(upit, vrednost)
        konekcija.commit()
        return redirect(url_for("render_stanovi"))
##############################################################################

########################## Logika za Kuce  #############################
##############################################################################
### GET ALL KUCE
@app.route('/kuce', methods=['GET'])
def render_kuce():
    if auth():
        upit = "select * from kuce"
        kursor.execute(upit)
        kuce = kursor.fetchall()
        return render_template('kuce.html', kuce = kuce)

### GET KUCE BY ID
@app.route('/kuca/<id>', methods=['GET'])
def render_kuce_by_id(id):
    if auth():
        upit="select * from kuce where id=%s"
        vrednost = (int(id),)
        kursor.execute(upit, vrednost)
        kuca = kursor.fetchone()
        return render_template('kuca.html', kuca = kuca)

### UPDATE KUCE BY ID
@app.route('/update_kuce/<id>', methods=["GET","POST"])      
def update_kuce(id):
    if auth() and isAdmin():
        tempID = int(id)
        if request.method == "GET":
            upit="select * from kuce where id=%s"
            vrednost = (tempID, )
            kursor.execute(upit, vrednost)
            kuca = kursor.fetchone()
            return render_template("update_kuce.html", kuca=kuca)

        if request.method == "POST":
            upit = """update kuce set cena  = %s, adresa = %s, kvadratura = %s, cena_po_kvadratu = %s, oglasavac = %s, slika = %s, broj_soba = %s where id=%s"""

            forma = request.form
            vrednosti = (
                forma["cena"],
                forma["adresa"],
                forma["kvadratura"],
                forma["cena_po_kvadratu"],
                forma["oglasavac"],
                forma["slika"],
                forma["broj_soba"],
                tempID
            )
            kursor.execute(upit, vrednosti)
            konekcija.commit()
            return redirect(url_for('render_kuce'))

### ADD KUCA BY ID
@app.route('/add_kuce', methods=["GET","POST"])      
def add_kuce():
    if auth() and isAdmin():
        if request.method == "GET":
            return render_template("add_kuce.html")
        if request.method == "POST":
            forma = request.form
            vrednosti = (
                    forma["cena"],
                    forma["adresa"],
                    forma["kvadratura"],
                    forma["cena_po_kvadratu"],
                    forma["oglasavac"],
                    forma["slika"],
                    forma["broj_soba"],
            )
            upit = "insert into kuce(cena,adresa,kvadratura,cena_po_kvadratu,oglasavac,slika,broj_soba) values (%s, %s, %s, %s, %s, %s, %s)"
            kursor.execute(upit, vrednosti)
            konekcija.commit()  
            return redirect(url_for("render_kuce"))        

### DELETE KUCA BY ID
@app.route('/delete_kuce_by_id/<id>', methods=["POST"])
def delete_kuce_by_id(id):
    if auth() and isAdmin():
        upit="delete from kuce where id=%s"
        vrednost = (int(id), )
        kursor.execute(upit, vrednost)
        konekcija.commit()
        return redirect(url_for("render_kuce"))
##############################################################################

########################## Logika za Lokale  #############################
##############################################################################
### GET ALL LOKALI
@app.route('/lokali', methods=['GET'])
def render_lokali():
    if auth():
        upit = "select * from lokali"
        kursor.execute(upit)
        lokali = kursor.fetchall()
        return render_template('lokali.html', lokali = lokali)

### GET LOKAL BY ID
@app.route('/lokal/<id>', methods=['GET'])
def render_lokal_by_id(id):
    if auth():
        upit="select * from lokali where id=%s"
        vrednost = (int(id),)
        kursor.execute(upit, vrednost)
        lokal = kursor.fetchone()
        return render_template('lokal.html', lokal = lokal)

### UPDATE LOKAL BY ID
@app.route('/update_lokal/<id>', methods=["GET","POST"])      
def update_lokal(id):
    if auth() and isAdmin():
        tempID = int(id)
        if request.method == "GET":
            upit="select * from lokali where id=%s"
            vrednost = (tempID, )
            kursor.execute(upit, vrednost)
            lokal = kursor.fetchone()
            return render_template("update_lokal.html", lokal=lokal)

        if request.method == "POST":
            upit = """update stanovi set cena  = %s, adresa = %s, kvadratura = %s, cena_po_kvadratu = %s, oglasavac = %s, slika = %s, broj_soba = %s where id=%s"""

            forma = request.form
            vrednosti = (
                forma["cena"],
                forma["adresa"],
                forma["kvadratura"],
                forma["cena_po_kvadratu"],
                forma["oglasavac"],
                forma["slika"],
                forma["broj_soba"],
                tempID
            )
            kursor.execute(upit, vrednosti)
            konekcija.commit()
            return redirect(url_for('render_lokali'))

### ADD LOKAL BY ID
@app.route('/add_lokal', methods=["GET","POST"])      
def add_lokal():
    if auth() and isAdmin():
        if request.method == "GET":
            return render_template("add_lokal.html")
        if request.method == "POST":
            forma = request.form
            vrednosti = (
                    forma["cena"],
                    forma["adresa"],
                    forma["kvadratura"],
                    forma["cena_po_kvadratu"],
                    forma["oglasavac"],
                    forma["slika"],
                    forma["broj_soba"],
            )
            upit = "insert into lokali(cena,adresa,kvadratura,cena_po_kvadratu,oglasavac,slika,broj_soba) values (%s, %s, %s, %s, %s, %s, %s)"
            kursor.execute(upit, vrednosti)
            konekcija.commit()  
            return redirect(url_for("render_lokali"))        

### DELETE LOKAL BY ID
@app.route('/delete_lokal_by_id/<id>', methods=["POST"])
def delete_lokal_by_id(id):
    if auth() and isAdmin():
        upit="delete from lokali where id=%s"
        vrednost = (int(id), )
        kursor.execute(upit, vrednost)
        konekcija.commit()
        return redirect(url_for("render_lokali"))
##############################################################################

#pokretanje aplikacije
app.run(debug=True)