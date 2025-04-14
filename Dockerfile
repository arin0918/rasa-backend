# Base image
FROM python:3.8

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && apt-get clean

# Copy requirements and install
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install spaCy separately and download model
RUN pip install spacy==3.5.3 && python -m spacy download en_core_web_md

# Copy project files
COPY . .

# Expose Rasa port
EXPOSE 8000

# Default command to run the Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug"]
