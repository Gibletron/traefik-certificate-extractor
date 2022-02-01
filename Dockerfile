# Use Python on Alpine Linux as base image
FROM python:alpine

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
            rsync \
            openssh-client \
            ca-certificates \
            apk-cron \
            openssl \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*

# Create working directory
RUN mkdir -p /app
RUN touch -p /app/script.sh
RUN chmod +x /app/script.sh
WORKDIR /app

# Copy requirements.txt to force Docker not to use the cache
COPY requirements.txt /app

# Install app dependencies
RUN pip3 install -r requirements.txt

# Copy app source
COPY . /app

# Define entrypoint of the app
ENTRYPOINT ["python3", "-u", "extractor.py"]
