from flask import Flask, jsonify, request

app = Flask(__name__)

tasks = [
    {"id": 1, "task": "Learn DevOps"},
    {"id": 2, "task": "Build Project"}
]

@app.route("/tasks", methods=["GET"])
def get_tasks():
    return jsonify(tasks)

@app.route("/tasks", methods=["POST"])
def add_task():
    data = request.get_json(silent=True)

    if data and "task" in data:
        task = data["task"]
    else:
        task = request.form.get("task")

    new_task = {
        "id": len(tasks) + 1,
        "task": task
    }

    tasks.append(new_task)

    return jsonify({"message": "Task added", "data": new_task})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3002)