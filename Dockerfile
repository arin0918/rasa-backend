FROM python:3.8-slim

WORKDIR /app

# Install required system packages for spaCy & Rasa
RUN apt-get update && apt-get install -y gcc libffi-dev libssl-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy requirements and install them
COPY requirements.txt .

# Use correct pip and install packages with pydantic fix
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir rasa==3.5.17 rasa-sdk==3.5.1 spacy==3.5.3 pydantic==1.10.0

# Copy all source files
COPY . .

EXPOSE 8000

# Run spaCy model download at runtime (not build time to reduce image size)
CMD python -m spacy download en_core_web_md && \
    rasa run --enable-api --cors "*" --port 8000 --model models/20250413-234312-tame-survey.tar.gz
