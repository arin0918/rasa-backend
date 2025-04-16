FROM python:3.8-slim

USER root

RUN apt-get update && \
    apt-get install -y \
    git \
    build-essential \
    libhdf5-dev \
    libhdf5-serial-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/arin0918/rasa-backend.git .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python -m spacy download en_core_web_md

EXPOSE 5005

CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
