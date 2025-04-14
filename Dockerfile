# Base image (slim)
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Check Python version
RUN python --version

# Copy requirements and install Python packages
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install spaCy model via pip (lighter and avoids CLI install issues)
RUN pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_md-3.5.0/en_core_web_md-3.5.0-py3-none-any.whl

# Copy project files
COPY . .

# Expose port for Rasa
EXPOSE 8000

# Run Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug"]
