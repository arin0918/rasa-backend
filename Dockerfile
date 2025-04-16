FROM python:3.8-slim

WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy only necessary files
COPY . .

# Optional: Clean up all other models if they exist
RUN rm -rf models/* \
    && mkdir -p models/ \
    && cp models/20250129-190149-wicker-pita.tar.gz models/

# Expose Rasa default port
EXPOSE 8000

# Start Rasa with only the selected model
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "--port", "8000", "--model", "models/20250129-190149-wicker-pita.tar.gz"]
