FROM nginx:latest
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY index.html /usr/share/nginx/html
EXPOSE 80
