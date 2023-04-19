FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY index.html /usr/share/nginx/html
FROM python:3.9

# Define a variável de ambiente PYTHONUNBUFFERED para garantir que a saída do Python seja exibida imediatamente
ENV PYTHONUNBUFFERED=1

# Copia o código fonte para a imagem do Docker
COPY . /app

# Define o diretório de trabalho para /app
WORKDIR /app

# Instala as dependências do projeto a partir do arquivo requirements.txt
RUN pip install -r requirements.txt

# Expõe a porta 5000 usada pela aplicação Flask
EXPOSE 5000

# Define o comando a ser executado quando o contêiner é iniciado
CMD ["python", "app.py"]
