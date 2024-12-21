from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

users = {"admin": {"password": "password", "profile": {"email": "admin@example.com", "name": "Admin"}}}

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")
    user = users.get(username)
    if user and user["password"] == password:
        return jsonify({"message": "Login successful", "profile": user["profile"]}), 200
    return jsonify({"message": "Invalid credentials"}), 401

@app.route('/recognize', methods=['POST'])
def recognize():
    data = request.get_json()
    coin_type = data.get("coin_type")
    return jsonify({"message": f"Recognized {coin_type}"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
