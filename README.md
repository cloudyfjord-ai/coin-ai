# Coin Recognition App
## Author
Marci Wojcik with ChatGPT AI assist

## Overview
This project is a cloud-native web and mobile application for recognizing coins and currencies. It integrates with backend services for authentication and coin recognition.

## Features
- User Authentication
- Coin and Currency Recognition
- Web and Mobile Frontends

## Setup Instructions
1. Clone the repository.
2. Run the `setup.sh` script to initialize and deploy the project.

## Technology Stack
- React (Web Frontend)
- React Native (Mobile Frontend)
- Flask (Backend)
- Docker & Kubernetes

- # Coin AI: Currency Recognition and Management Application

Coin AI is a cloud-native application that recognizes coins and currencies, integrates with AI-based logic for account services, and offers cross-platform compatibility for both iOS and Android mobile devices. This application also supports web-based access.

## Features
- **Currency Recognition**: AI-driven detection of coins and notes.
- **User Management**: Account creation, login, and profile management.
- **Cross-Platform**: React Native mobile apps for iOS and Android, alongside a web-based front end.
- **Cloud Backend**: Scalable backend running on Docker and Kubernetes, deployed via a CI/CD pipeline.
- **Environment Configurations**: Separate configurations for test, integration, and production environments managed through YAML files.

---

## Installation

### Prerequisites
1. **Operating System**: macOS, Linux, or Windows (with Docker installed).
2. **Software Dependencies**:
   - [Docker](https://www.docker.com/)
   - [Kubernetes](https://kubernetes.io/)
   - [Gradle](https://gradle.org/)
   - [Git](https://git-scm.com/)
   - [Node.js and npm](https://nodejs.org/)
   - [React Native CLI](https://reactnative.dev/docs/environment-setup)
   - [Python 3.x](https://www.python.org/) (for backend API)

3. **Accounts**:
   - **DockerHub**: `mrwojcik1`
   - **GitHub**: `cloudyfjord-ai`
   - **AWS**: Amazon EC2 under the account `cloudyfjord`.

---

### Setup Instructions

1. **Clone the Repository**:
   git clone https://github.com/cloudyfjord-ai/coin-ai.git
   cd coin-ai
   
Run the Setup Script: Execute the setup script to configure the environment, build the project, and deploy:

bash setup.sh
Environment Configuration:

The script will automatically detect the environment (macOS/Linux) and install necessary dependencies.
YAML files (config/test.yaml, config/integration.yaml, config/production.yaml) are used for environment-specific configurations.
Usage
Running the Application Locally
Start the Backend:

bash

cd backend
python app.py
Start the Web Frontend:

bash

cd frontend/web
npm install
npm start
Start the Mobile Frontend:

bash

cd frontend/mobile
npm install
react-native run-android # For Android
react-native run-ios # For iOS
Accessing the Application
Web Interface: Open http://localhost:3000 in your browser.
Mobile App: Use the React Native application on your mobile device.
Deployment
CI/CD Pipeline
The setup script automatically configures a Jenkins CI/CD pipeline for continuous integration and deployment.
To trigger a build:
Commit changes to the GitHub repository (main branch).
Jenkins will handle the build and deploy process to Kubernetes on AWS EC2.
Docker and Kubernetes
The application is containerized using Docker.
Kubernetes manages the containers, ensuring scalability and reliability.
Testing
Unit Tests:

Backend: Run tests using pytest.
bash

cd backend
pytest
Frontend: Run tests using npm.
bash

cd frontend/web
npm test
End-to-End Tests:

Utilize tools like Selenium for web testing and Appium for mobile testing.
Contributing
We welcome contributions! To contribute:

Fork the repository.
Create a feature branch:
bash

git checkout -b feature/your-feature
Push your changes and create a pull request.
License
This project is licensed under the MIT License. See the LICENSE file for details.

Contact
For support or inquiries, please contact:

GitHub Issues: https://github.com/cloudyfjord-ai/coin-ai/issues
Email: support@cloudyfjord.ai

## About CloudyFjord AI
CloudyFjord AI is a state-of-the-art currency recognition platform designed for web and mobile applications. Developed by [Your Name/Organization], it uses advanced AI to simplify financial tasks.
Add a "Keywords" section at the end:


## Keywords
coin recognition, AI, cloud-native application, React Native, Flutter, Kubernetes, Docker, CloudyFjord AI




