from flask import Flask, render_template
import requests
from registry import services

app = Flask(__name__)

@app.route("/")
def home():
    users = requests.get(services["user"] + "/users").json()
    tasks = requests.get(services["task"] + "/tasks").json()
    return render_template("index.html", users=users, tasks=tasks)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)