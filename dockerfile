FROM nginx:latest

# html ve css dosyalarimizi belirleme islemi

COPY . usr/share/nginx/html

EXPOSE 80


