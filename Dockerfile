FROM python:3.10-slim

WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ✅ Make sure spaCy medium model is downloaded
RUN python -m spacy download en_core_web_md && python -m spacy validate

# Copy the entire app
COPY . .

# Expose port
EXPOSE 8000

# ✅ Prevent memory crash (sets memory limit in container)
CMD ["bash", "-c", "ulimit -v 2097152 && rasa run --enable-api --port 8000 --cors '*'"]
