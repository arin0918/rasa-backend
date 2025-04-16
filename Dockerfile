FROM python:3.8-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Download and link the small SpaCy model (if needed)
RUN python -m spacy download en_core_web_md \
    && python -m spacy link en_core_web_md en_core_web_md

# Copy all project files
COPY . .

# Clean up and keep only one model
RUN rm -rf models/* \
    && mkdir -p models/ \
    && cp models/20250129-190149-wicker-pita.tar.gz models/

# Expose Rasa server port
EXPOSE 8000

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug", "--port", "8000", "--model", "models/20250129-190149-wicker-pita.tar.gz"]
