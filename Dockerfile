FROM python:3.8-slim

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python packages (with pydantic 1.10.0 for Rasa compatibility)
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy all files
COPY . .

# Expose Rasa default port
EXPOSE 8000

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "--port", "8000"]
