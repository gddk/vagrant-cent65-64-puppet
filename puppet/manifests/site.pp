node 'vbox.vm' { 
	
	## Configure mysql
	class { '::mysql::server':
		root_password    => 'mysql',
		override_options => { 'mysqld' => { 'max_connections' => '1024' } },
		databases => {
			'graphite' => {
				ensure  => 'present',
				charset => 'utf8',
			},
		},
		users => {
			'graphite@localhost' => {
				ensure                   => 'present',
				max_connections_per_hour => '0',
				max_queries_per_hour     => '0',
				max_updates_per_hour     => '0',
				max_user_connections     => '0',
				password_hash            => '*5E34E8C9BEC59CA63C2B30F6D06BD36D338E0454',
			},
		}
	}	

	
#	# Configure elasticsearch
#	class { 'elasticsearch': 
#		autoupgrade => true,
#		config => {
#			'cluster' => {
#				'name' => 'ecluster',
#				'routing.allocation.awareness.attributes' => 'rack'
#			}
#		}
#	}
#	
#	# Configure logstash
#	class { 'logstash': }
#	
#
#	# Configure kibana3
#	class { 'kibana3': }

	# configure memcache
	class { 'memcached':
      max_memory => '12%'
    }
		
	# Configure 
	class { 'graphite':
		gr_max_updates_per_second => 100,
		gr_timezone               => 'America/Phoenix',
		secret_key                => 'fd79qjlcaqo49247lK34534Vj',
		gr_storage_schemas        => [
		  {
			name       => 'carbon',
			pattern    => '^carbon\.',
			retentions => '1m:90d'
		  },
		  {
			name       => 'special_server',
			pattern    => '^longtermserver_',
			retentions => '10s:7d,1m:365d,10m:5y'
		  },
		  {
			name       => 'default',
			pattern    => '.*',
			#retentions => '60:43200,900:350400'
			retentions => '1m:90d'
		  }
		],
		gr_django_db_engine       => 'django.db.backends.mysql',
		gr_django_db_name         => 'graphite',
		gr_django_db_user         => 'graphite',
		gr_django_db_password     => 'mysqlpassword',
		gr_django_db_host         => 'localhost',
		gr_django_db_port         => '3306',
		gr_memcache_hosts         => ['127.0.0.1:11211']
	}	
}