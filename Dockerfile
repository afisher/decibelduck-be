FROM python:3.8-slim

ENV PYTHONUNBUFFERED True
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./
RUN pip install --no-cache-dir .

CMD exec gunicorn --bind :$PORT --worker-class uvicorn.workers.UvicornWorker decibelduck.main:app
