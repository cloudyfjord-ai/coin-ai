from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if data['username'] == 'admin' and data['password'] == 'password':
        return jsonify({"message": "Login successful!"}), 200
    return jsonify({"message": "Invalid credentials!"}), 401

@app.route('/user/profile', methods=['GET'])
def profile():
    return jsonify({"username": "admin", "role": "admin"}), 200

@app.route('/recognize', methods=['POST'])
def recognize():
    return jsonify({"result": "Detected coin: Quarter, value: ./setup.sh.25"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
