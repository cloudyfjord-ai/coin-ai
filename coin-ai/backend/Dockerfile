FROM python:3.8-slim
WORKDIR /app
COPY . .
RUN pip install flask flask-sqlalchemy flask-bcrypt flask-jwt-extended tensorflow
CMD ["python", "app.py"]
