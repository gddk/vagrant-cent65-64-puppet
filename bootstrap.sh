#!/usr/bin/env bash
#set -e

if [ "$EUID" -ne "0" ] ; then
        echo "Script must be run as root." >&2
        exit 1
fi

echo "Setting the mysql root password back to empty string"
echo "because the puppetlabs/mysql expects it that way"
mysqladmin -u root -pmysql password ''

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