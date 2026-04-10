from flask import Flask, jsonify, request

app = Flask(__name__)

# In-memory data
users = [
    {"id": 1, "name": "Akash"},
    {"id": 2, "name": "DevOps User"}
]

# GET users
@app.route("/users", methods=["GET"])
def get_users():
    return jsonify(users)

# ADD user (POST)
@app.route("/users", methods=["POST"])
def add_user():
    new_user = request.json
    users.append(new_user)
    return jsonify({"message": "User added", "data": new_user})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3001)