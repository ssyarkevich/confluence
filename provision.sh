#!/usr/bin/bash
echo "Starting deploying our app..."
yum install -y wget 
wget --max-redirect 3 --progress=bar:force https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
#curl --remote-name -# --location https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-6.2.1-x64.bin
chmod a+x atlassian-confluence-6.2.1-x64.bin && cp /vagrant/response.varfile .
sudo ./atlassian-confluence-6.2.1-x64.bin -q varfile response.varfile
