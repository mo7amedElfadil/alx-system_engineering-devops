# install and configure nginx
exec { 'update':
    command => '/usr/bin/apt-get update',
}
package { 'nginx':
    ensure  => installed,
    require => Exec['update'],
  }
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
   add_header X-Served-By ${hostname};
    try_files \$uri \$uri/ =404;
  }
  location /redirect_me {
    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
  }
}
",
    require => Package['nginx'],
  }
exec {'run':
    command     => '/usr/sbin/service nginx restart',
    refreshonly => true,
    subscribe   => File['/etc/nginx/sites-available/default'],
  }
