FROM nginx
RUN apt-get update && apt-get install -y \
    libc6 \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY index.html /usr/share/nginx/html
