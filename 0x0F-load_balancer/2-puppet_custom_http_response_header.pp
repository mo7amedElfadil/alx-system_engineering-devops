# install and configure nginx
class nginx {
  exec { 'update':
    command => '/usr/bin/apt-get update',
}
  package { 'nginx':
    ensure  => installed,
    require => Exec['update'],
  }
  file_line { 'header':
    path     => '/etc/nginx/sites-available/default',
    match    => '^location / {',
    line     => "location / {\n\tadd_header X-Served-By \"${hostname}\";",
    multiple => false,
    notify   => Exec['run'],
  }
  exec {'run':
    command     => '/usr/sbin/service nginx restart',
    refreshonly => true,
    subscribe   => File_line['header'],
  }
}
include nginx
