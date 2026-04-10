from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/users')
def get_users():
    return jsonify([
        {"id": 1, "name": "Akash"},
        {"id": 2, "name": "DevOps User"}
    ])

app.run(host="0.0.0.0", port=3001)