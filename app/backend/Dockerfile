# 🔹 Base image: using lightweight official Python image with pip
FROM python:3.11-slim

# 🔹 Set working directory inside container
WORKDIR /app

# 🔹 Copy files to container
COPY app.py .
COPY requirements.txt .

# 🔹 Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 🔹 Optional: document the port used by the app (Flask uses 5000)
EXPOSE 5000

# 🔹 Healthcheck to monitor the container
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1

# 🔹 Run the app when the container starts
CMD ["python", "app.py"]
