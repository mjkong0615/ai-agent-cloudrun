# Use the official Python image
FROM python:3.13-slim

RUN mkdir -p /agent-root/zoo
COPY . /agent-root/zoo
WORKDIR /agent-root/zoo
ENV PYTHONUNBUFFERED=1
RUN pip install -r requirement.txt

WORKDIR /agent-root

EXPOSE 8000

CMD ["adk", "web", "--host", "0.0.0.0"]