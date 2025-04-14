# Use a base image with Python preinstalled
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose port for the web service
EXPOSE 8000

# Set the command to run Rasa with the correct model file
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "8000", "--debug", "--model", "models/20250413-234312-tame-survey.tar.gz"]
