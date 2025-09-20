# Use the official Python image
FROM python:3.13-slim

COPY . /app
WORKDIR /app
ENV PYTHONUNBUFFERED=1
RUN pip install -r requirement.txt

EXPOSE 8000

CMD ["adk", "web"]