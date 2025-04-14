# Base image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && apt-get clean

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy entire project files
COPY . .

# Expose Rasa default port
EXPOSE 8000

# Run Rasa server with specified model (update the model filename if different)
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug", "--model", "models/20250320-050304-tough-limit.tar.gz"]
