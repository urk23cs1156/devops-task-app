from flask import Flask, jsonify, request

app = Flask(__name__)

users = [
    {"id": 1, "name": "Akash"},
    {"id": 2, "name": "DevOps User"}
]

@app.route("/users", methods=["GET"])
def get_users():
    return jsonify(users)

@app.route("/users", methods=["POST"])
def add_user():
    data = request.get_json(silent=True)

    if data and "name" in data:
        name = data["name"]
    else:
        name = request.form.get("name")

    new_user = {
        "id": len(users) + 1,
        "name": name
    }

    users.append(new_user)

    return jsonify({"message": "User added", "data": new_user})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3001)