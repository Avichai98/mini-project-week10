import logging
from flask import Flask, request, jsonify
from pymongo import MongoClient
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

# Mongo connection
mongo_uri = os.environ.get("MONGO_URI", "mongodb://mongo:27017/mydatabase")
client = MongoClient(mongo_uri)
db = client.get_database()
names_collection = db.names

# Setup logging
logging.basicConfig(level=logging.INFO)

@app.before_request
def log_request_info():
    app.logger.info(f"{request.method} {request.path} from {request.remote_addr}")

@app.route("/names", methods=["GET"])
def get_names():
    names = list(names_collection.find({}, {"_id": 0}))
    return jsonify(names), 200

@app.route("/names", methods=["POST"])
def add_name():
    data = request.json
    if not data or "name" not in data:
        return jsonify({"error": "Missing 'name'"}), 400
    names_collection.insert_one({"name": data["name"]})
    return jsonify({"message": "Name added"}), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
