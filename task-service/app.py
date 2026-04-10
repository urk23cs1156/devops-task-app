from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/tasks')
def get_tasks():
    return jsonify([
        {"id": 1, "task": "Learn DevOps"},
        {"id": 2, "task": "Build Project"}
    ])

app.run(host="0.0.0.0", port=3002)