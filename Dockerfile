# Use minimal Python image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install only required system packages
RUN apt-get update && apt-get install -y \
    gcc \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Do NOT download spaCy model here (we'll do it at runtime to reduce image size)

# Copy project files
COPY . .

# Expose Rasa port
EXPOSE 8000

# Download spaCy model and run Rasa server
CMD python -m spacy download en_core_web_sm && rasa run --enable-api --cors "*" --port 8000 --debug
