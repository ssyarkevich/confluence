#!/usr/bin/bash
echo "Starting deploying our app..."
yum install -y nginx && mkdir -p /etc/nginx/ssl/confluence.ssyarkev.com && cd /etc/nginx/ssl/confluence.ssyarkev.com
yum install -y openssl
openssl req -nodes -newkey rsa:2048 -keyout self-ssl.key -out self-ssl.csr -subj "/C=UA/ST=Lviv region/L=Lviv/O=Epam student/OU=IT Department/CN=confluence.ssyarkev.com"
openssl x509 -req -days 365 -in self-ssl.csr -signkey self-ssl.key -out self-ssl.crt
yum install -y wget 
wget --max-redirect 3 --progress=bar:force https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
#curl --remote-name -# --location https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
chmod a+x atlassian-confluence-6.2.1-x64.bin && cp /vagrant/response.varfile .
sudo ./atlassian-confluence-6.2.1-x64.bin -q varfile response.varfile
