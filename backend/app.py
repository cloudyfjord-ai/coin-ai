from flask import Flask, jsonify, request
import jwt
import datetime

app = Flask(__name__)
app.secret_key = 'your_secret_key'

users = {"admin": {"password": "password", "role": "admin"}}

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    if username in users and users[username]['password'] == password:
        token = jwt.encode({
            'username': username,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)
        }, app.secret_key, algorithm="HS256")
        return jsonify({"token": token}), 200
    return jsonify({"message": "Invalid credentials!"}), 401

@app.route('/user/profile', methods=['GET'])
def profile():
    token = request.headers.get("Authorization")
    try:
        decoded = jwt.decode(token, app.secret_key, algorithms=["HS256"])
        username = decoded["username"]
        return jsonify({"username": username, "role": users[username]["role"]}), 200
    except jwt.ExpiredSignatureError:
        return jsonify({"message": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"message": "Invalid token"}), 401

@app.route('/recognize', methods=['POST'])
def recognize():
    # Mock response for coin recognition
    return jsonify({"result": "Detected coin: Quarter, value: ./setup.sh.25"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
