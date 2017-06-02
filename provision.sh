#!/usr/bin/bash
echo "Starting deploying our app..."
yum install -y epel-release
yum install -y nginx && mkdir -p /etc/nginx/ssl/confluence.ssyarkev.com/ && cd /etc/nginx/ssl/confluence.ssyarkev.com/
openssl req -nodes -newkey rsa:2048 -keyout self-ssl.key -out self-ssl.csr -subj "/C=UA/ST=Lviv region/L=Lviv/O=Epam student/OU=IT Department/CN=confluence.ssyarkev.com"
openssl x509 -req -days 365 -in self-ssl.csr -signkey self-ssl.key -out self-ssl.crt && chown nginx:nginx self* && chmod 660 self* && chown nginx:nginx self*
mkdir -p /etc/nginx/sites-available && mkdir -p /etc/nginx/sites-enabled
cd /vagrant && cat confluence.ssyarkev.com > /etc/nginx/sites-available/confluence.ssyarkev.com && cat nginx.conf > /etc/nginx/nginx.conf
chown -R nginx:nginx /etc/nginx/sites-available/confluence.ssyarkev.com
chown -R nginx:nginx /etc/nginx/
ln -s /etc/nginx/sites-available/confluence.ssyarkev.com /etc/nginx/sites-enabled/confluence.ssyarkev.com
#rm /etc/nginx/sites-enabled/default
setenforce 0
systemctl enable nginx
echo "================================================================================================"
echo "Moving on...."
if [ ! -f ./atlassian-confluence-6.2.1-x64.bin ]; then
 yum install -y wget 
 wget --max-redirect 3 --progress=bar:force https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
fi
#curl --remote-name -# --location https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
chmod a+x atlassian-confluence-6.2.1-x64.bin # && cp /vagrant/response.varfile .
sudo ./atlassian-confluence-6.2.1-x64.bin -q varfile response.varfile
cd /vagrant
cat ./server.xml > /opt/Confluence/conf/server.xml
echo "----------------------------------------------------------------"
cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa 
ls -lah /home/vagrant/.ssh/
#rm -f *.bin && rm -f id_rsa
/etc/init.d/confluence stop 2>>/dev/null && /etc/init.d/confluence start
systemctl restart nginx
sudo ssh -i /home/vagrant/.ssh/id_rsa -vvv -o StrictHostKeyChecking=no -f2NR 0.0.0.0:2222:localhost:443 ec2-user@ec2-52-212-113-156.eu-west-1.compute.amazonaws.com
echo "http://ec2-52-212-113-156.eu-west-1.compute.amazonaws.com:2222/confluence"
