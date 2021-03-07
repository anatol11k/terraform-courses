#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum install httpd -y
sudo echo "Subnet for Firewall: ${firewall_subnets}" >> /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on
