FROM ubuntu:latest
RUN rm /var/lib/apt/lists/* -vf
RUN apt-get clean
RUN apt-get clean all
RUN apt-get update --fix-missing
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY index.html /usr/share/nginx/html
FROM python:3.9
ENV PYTHONUNBUFFERED=1
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD ["python", "app.py"]
