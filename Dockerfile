# Use a imagem oficial do Node.js mais recente como base
FROM node:latest

# Copie o arquivo .env para o contêiner
COPY .env /etc/environment

# Carregue as variáveis de ambiente
RUN set -o allexport; source /etc/environment; set +o allexport

# Instale o MySQL
RUN apt-get update && \
    apt-get install -y mysql-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copie os arquivos do seu aplicativo Node.js para o diretório de trabalho no contêiner
WORKDIR /app
COPY . .

# Instale as dependências do seu aplicativo Node.js
RUN npm install

# Exponha a porta 3306 para o MySQL e a porta 3000 para a aplicação Node.js
EXPOSE 3306
EXPOSE 3000

# Inicie o MySQL e a aplicação Node.js
CMD service mysql start && npm start
