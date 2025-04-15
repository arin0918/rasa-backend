FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install dependencies and upgrade pip
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Download the spaCy model (en_core_web_md) at build time
RUN python -m spacy download en_core_web_md

# Copy the rest of your application into the container
COPY . .

# Expose the port (if needed for API communication)
EXPOSE 8000

# Set the command to run your Rasa server with the required configurations
CMD ["rasa", "run", "--enable-api", "--port", "8000", "--cors", "*"]
