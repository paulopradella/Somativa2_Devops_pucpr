FROM nginx:latest
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget ca-certificates xz-utils && \
    wget -qO- https://nodejs.org/dist/v16.13.2/node-v16.13.2-linux-x64.tar.xz | tar xJ -C /usr/local --strip-components=1 && \
    apt-get remove -y wget xz-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY index.html /usr/share/nginx/html
