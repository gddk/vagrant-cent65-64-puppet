#!/usr/bin/env bash
#set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

echo "Add the EPEL repo"
rpm -Uvh http://epel.mirror.net.in/epel/6/i386/epel-release-6-8.noarch.rpm

echo "Update all packages"
yum update -y

echo "install mysql client"
yum install -y mysql mysql-server

echo "Start mysql"
chkconfig mysqld on
/etc/init.d/mysqld start
sleep 2;

echo "Create db/user graphite"
echo 'mysql -u root -e "CREATE DATABASE graphite"'
mysql -u root -e "CREATE DATABASE graphite"
echo 'mysql -u root -e "GRANT ALL PRIVILEGES ON graphite.* TO graphite@localhost"'
mysql -u root -e "GRANT ALL PRIVILEGES ON graphite.* TO graphite@localhost IDENTIFIED BY 'mysqlpassword'"

echo 'mysqladmin -u root password "mysql"'
mysqladmin -u root password "mysql"

echo "Adding elasticsearch key and repo"
rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch

echo "[elasticsearch-1.0]
name=Elasticsearch repository for 1.0.x packages
baseurl=http://packages.elasticsearch.org/elasticsearch/1.0/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1

[logstash-1.3]
name=logstash repository for 1.3.x packages
baseurl=http://packages.elasticsearch.org/logstash/1.3/centos
gpgcheck=1
gpgkey=http://packages.elasticsearch.org/GPG-KEY-elasticsearch
enabled=1
" > /etc/yum.repos.d/elasticsearch.repo

echo "Installing Puppet repo for CentOS 6 x86_64"
rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm

#echo "Update all packages again"
#yum update -y

echo "Install puppet"
yum install -y puppet


echo "Install telnet"
yum install -y telnet

#echo "Fix 'vboxsf' file system is not available bug"
#ln -fs /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib64/VBoxGuestAdditions

#echo "Install bundler"
#gem install bundler

#echo "Install ruby-devel"
#yum install -y ruby-devel 

echo "Install RVM"
curl -L get.rvm.io | bash -s stable
#
echo "Create system environment using a script"
source /etc/profile.d/rvm.sh
#
echo "Install ruby 2.1.1"
rvm reload
rvm install 2.1.1
#
echo "Install ruby 1.9.3"
rvm reload
rvm install 1.9.3
#
echo "List rubies"
rvm list rubies
#
echo "Set ruby system as default, else puppet fails"
rvm use system --default


echo "install and start http"
yum install -y httpd
chkconfig httpd on
/etc/init.d/httpd restart

echo "puppet module install puppetlabs-mysql --modulepath /vagrant/puppet/modules"
puppet module install puppetlabs-mysql --modulepath /vagrant/puppet/modules

echo "puppet module install dwerder-graphite --modulepath /vagrant/puppet/modules"
puppet module install dwerder-graphite --modulepath /vagrant/puppet/modules


echo "puppet module install elasticsearch-elasticsearch --modulepath /vagrant/puppet/modules"
puppet module install elasticsearch-elasticsearch --modulepath /vagrant/puppet/modules


echo "puppet module install elasticsearch-logstash --modulepath /vagrant/puppet/modules"
puppet module install elasticsearch-logstash --modulepath /vagrant/puppet/modules


echo "puppet module install saz-memcached --modulepath /vagrant/puppet/modules"
puppet module install saz-memcached --modulepath /vagrant/puppet/modules



exit 0