# install nginx
class nginx {
  package { 'nginx':
    ensure => 'installed',
  }
  # create a file with content
  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello world!
	',
    require => Package['nginx'],
  }

  # modify the default nginx configuration
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => "
    server {
		listen 80 default_server;
		listen [::]:80 default_server;
		root /var/www/html;
		index index.html;
		server_name _;
		location / {
			try_files \$uri \$uri/ =404;
		}
		location /redirect_me {
			return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
		}
	  }
  ",
    require => Package['nginx'],
  }
  service {'nginx':
    ensure    => 'running',
    enable    => true,
    subscribe => File['/etc/nginx/sites-available/default'],
  }
}

include nginx
