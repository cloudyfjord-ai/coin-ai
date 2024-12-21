#!/bin/bash

# Define variables
REPO_URL="https://github.com/cloudyfjord-ai/coin-ai.git"
DOCKER_USERNAME="mrwojcik1"
DOCKER_IMAGE="coin-ai-backend"
PROJECT_DIR="coin-ai"
BACKEND_DIR="${PROJECT_DIR}/backend"
WEB_DIR="${PROJECT_DIR}/frontend/web"
MOBILE_DIR="${PROJECT_DIR}/frontend/mobile"
K8S_DIR="${PROJECT_DIR}/k8s"

# Ensure dependencies are installed
install_dependencies() {
  echo "Installing required dependencies..."
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Installing..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install git wget python3 docker kubectl gradle
  else
    # Linux
    sudo apt update && sudo apt install -y git wget python3 python3-pip docker.io kubectl gradle
  fi
}

# Set up the project directory
setup_project_structure() {
  echo "Setting up project structure..."
  rm -rf $PROJECT_DIR
  mkdir -p $BACKEND_DIR $WEB_DIR $MOBILE_DIR $K8S_DIR
}

# Generate backend files
generate_backend() {
  echo "Generating backend files..."
  cat > $BACKEND_DIR/app.py << 'EOF'
from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_jwt_extended import JWTManager, create_access_token
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import img_to_array, load_img
import numpy as np

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///coinai.db'
app.config['JWT_SECRET_KEY'] = 'super-secret-key'
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
jwt = JWTManager(app)

model = load_model("coin_recognition_model.h5")
classes = ['Penny', 'Nickel', 'Dime', 'Quarter', 'Dollar']

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    hashed_password = bcrypt.generate_password_hash(data['password']).decode('utf-8')
    new_user = User(username=data['username'], password=hashed_password)
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'message': 'User registered successfully'}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(username=data['username']).first()
    if user and bcrypt.check_password_hash(user.password, data['password']):
        access_token = create_access_token(identity={'username': user.username})
        return jsonify({'token': access_token}), 200
    return jsonify({'error': 'Invalid credentials'}), 401

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400
    file = request.files['file']
    img = load_img(file, target_size=(128, 128))
    img_array = img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    predictions = model.predict(img_array)
    predicted_class = classes[np.argmax(predictions)]
    confidence = np.max(predictions)
    return jsonify({'class': predicted_class, 'confidence': confidence})

if __name__ == '__main__':
    db.create_all()
    app.run(host='0.0.0.0', port=5000)
EOF

  # Create Dockerfile for backend
  cat > $BACKEND_DIR/Dockerfile << EOF
FROM python:3.8-slim
WORKDIR /app
COPY . .
RUN pip install flask flask-sqlalchemy flask-bcrypt flask-jwt-extended tensorflow
CMD ["python", "app.py"]
EOF
}

# Generate web frontend files
generate_web_frontend() {
  echo "Generating web frontend files..."
  mkdir -p $WEB_DIR/src/components
  cat > $WEB_DIR/src/App.js << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './components/Login';
import Register from './components/Register';
import Upload from './components/Upload';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/upload" element={<Upload />} />
      </Routes>
    </Router>
  );
}

export default App;
EOF
}

# Generate mobile frontend files
generate_mobile_frontend() {
  echo "Generating mobile frontend files..."
  cat > $MOBILE_DIR/App.js << 'EOF'
import React from 'react';
import { View, Text, Button, TextInput, StyleSheet } from 'react-native';

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Coin AI App</Text>
      <TextInput placeholder="Username" style={styles.input} />
      <TextInput placeholder="Password" secureTextEntry style={styles.input} />
      <Button title="Login" onPress={() => {}} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center' },
  input: { borderWidth: 1, marginBottom: 10, width: 200, padding: 8 },
});
EOF
}

# Push code to GitHub
push_to_github() {
  echo "Pushing code to GitHub..."
  git init
  git remote add origin $REPO_URL
  git add .
  git commit -m "Initial commit"
  git branch -M main
  git push -u origin main --force
}

# Main execution
main() {
  install_dependencies
  setup_project_structure
  generate_backend
  generate_web_frontend
  generate_mobile_frontend
  push_to_github
  echo "Setup complete! Project pushed to $REPO_URL"
}

main

