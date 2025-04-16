# Use smaller base image with Python 3.8
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Do NOT install spaCy model here — it’s heavy and causes Koyeb image size to exceed 2GB
# We'll download it at runtime if needed

# Copy project files
COPY . .

# Expose Rasa port
EXPOSE 8000

# Default command to run the Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug"]
