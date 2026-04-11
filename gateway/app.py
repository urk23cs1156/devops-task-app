from flask import Flask, render_template, request, redirect
import requests
from registry import services

app = Flask(__name__)

@app.route("/")
def home():
    users = requests.get(services["user"] + "/users").json()
    tasks = requests.get(services["task"] + "/tasks").json()
    return render_template("index.html", users=users, tasks=tasks)

@app.route("/add-user", methods=["POST"])
def add_user():
    name = request.form.get("name")

    requests.post(
        services["user"] + "/users",
        json={"name": name}
    )

    return redirect("/")

@app.route("/add-task", methods=["POST"])
def add_task():
    task = request.form.get("task")

    requests.post(
        services["task"] + "/tasks",
        json={"task": task}
    )

    return redirect("/")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000)