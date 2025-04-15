FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ✅ Download the small SpaCy model (low memory)
RUN python -m spacy download en_core_web_sm

COPY . .

EXPOSE 8000

CMD ["rasa", "run", "--enable-api", "--port", "8000", "--cors", "*"]
