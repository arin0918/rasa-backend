# Base image
FROM python:3.8

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
    && apt-get clean

# Check Python version
RUN python --version

# Copy requirements and install dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install spaCy separately
RUN pip install spacy==3.5.3

# Download spaCy model with workaround
RUN python -m spacy download en_core_web_md || true

# Copy project files
COPY . .

# Expose Rasa port
EXPOSE 8000

# Default command to run the Rasa server
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug"]
