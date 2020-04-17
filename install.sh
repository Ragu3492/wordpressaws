#!/bin/bash
#usermod -a -G root ec2-user
if [ "$(whoami)" != "root" ]
then
    sudo su -s "$0"
    exit
fi
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git -y
sudo yum install httpd -y
sudo yum install wget -y
sudo systemctl start httpd && sudo systemctl enable httpd
sudo setenforce 0
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
sudo yum install php70w php70w-opcache php70w-mbstring php70w-gd php70w-xml php70w-pear php70w-fpm php70w-mysql php70w-pdo -y

sudo yum -y install mariadb-server
sudo systemctl start mariadb && sudo systemctl enable mariadb

#MySQL Consider changing values from drupaldb, drupaluser, and password
sudo echo "CREATE DATABASE zippyopsdb CHARACTER SET utf8 COLLATE utf8_general_ci;;" | mysql
sudo echo "CREATE USER 'zippyops'@'localhost' IDENTIFIED BY 'zippyops';" | mysql
sudo echo "GRANT ALL PRIVILEGES ON zippyopsdb.* TO 'zippyops'@'localhost';" | mysql
sudo echo "FLUSH PRIVILEGES;" | mysql


