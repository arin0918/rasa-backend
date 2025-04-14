# Base image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install minimal system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install spaCy small model (lightweight)
RUN pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-3.5.0/en_core_web_sm-3.5.0-py3-none-any.whl

# Copy project files
COPY . .

# Expose Rasa port
EXPOSE 8000

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug"]
