vagrant-cent65-64-puppet
========================

Example centos 6.5 x86_64 with puppet installed
Started as http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box
Since have added
+ yum update on 5/6/2014
+ Add the EPEL repo
+ install mysql client and server
+ Started mysql
+ Set root mysql password to mysql
+ Created db/user graphite with password mysqlpassword
+ Added elasticsearch key and repo
+ Installed Puppet repo for CentOS 6 x86_64
+ Installed puppet
+ Install RVM
+ Install ruby 2.1.1
+ Install ruby 1.9.3
+ install and start http
+ puppet module install puppetlabs-mysql --modulepath /vagrant/puppet/modules
+ puppet module install dwerder-graphite --modulepath /vagrant/puppet/modules
+ puppet module install elasticsearch-elasticsearch --modulepath /vagrant/puppet/modules
+ puppet module install elasticsearch-logstash --modulepath /vagrant/puppet/modules
+ puppet module install saz-memcached --modulepath /vagrant/puppet/modules
+ 
