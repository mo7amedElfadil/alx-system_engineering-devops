# install nginx
package { 'nginx':
  ensure => 'installed',
}

# create a file with content
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello world!',
  mode    => '0644',
  require => Package['nginx'],
}
# modify the default nginx configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "server {
	listen 80 default_server;
	listen [::]:80 default_server;
	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;
	location / {
		try_files \$uri \$uri/ =404;
	}
	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}
}",
  mode    => '0644',
}
service {'nginx':
  ensure    => 'running',
  enable    => true,
  require   => Package['nginx'],
  subscribe => File['/etc/nginx/sites-available/default'],
}
