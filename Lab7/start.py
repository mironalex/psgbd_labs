from flask import Flask, render_template, redirect, request
from flask_sqlalchemy import SQLAlchemy
import os
import random
import cx_Oracle

app = Flask(__name__)

basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'oracle+cx_oracle://student:STUDENT@localhost:49161/xe'
db = SQLAlchemy(app)

class Questions(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    chapter_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    question = db.Column(db.Text)
    answer = db.Column(db.Text)
    asked = db.Column(db.Integer)
    solved = db.Column(db.Integer)
    reported = db.Column(db.Integer)
    report_resolved = db.Column(db.Integer)
    created_at = db.Column(db.DateTime)
    updated_at = db.Column(db.DateTime)

@app.route("/")
def home():
    db.create_all()
    return render_template("home.html")

@app.route("/view", methods=["GET", "POST"])
def view_question():
    if request.method == "GET":
        return render_template("view_question.html")
    else:
        #q_id = request.form["id"];
        #result = db.engine.execute("select * from questions where id =" + q_id).first()
        q_id = int(request.form["id"])
        result = Questions.query.get(q_id)
        if result is None:
            return render_template("view_question.html", id = "Question does not exist.")
        return render_template("view_question.html", id = q_id, question = result.question, answer = result.answer)
# @app.route("/notes/create", methods=["GET", "POST"])
# def create_note():
#     if request.method == "GET":
#         return render_template("create_note.html")
#     else:
#         id = random.randint(1,1000000)
#         title = request.form["title"]
#         body = request.form["body"]
#
#         note = Notite(id=id, title=title, body=body)
#
#         db.session.add(note)
#         db.session.commit()
#
#         return redirect("/notes/create")

if __name__ == "__main__":
    app.run(debug=True)
