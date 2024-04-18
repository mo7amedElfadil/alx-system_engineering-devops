# sky is the limit
file { '/etc/default/nginx':
  ensure => present,
  notify => Exec['set_nginx_ulimit'],
}

exec { 'set_nginx_ulimit':
  command   => '/bin/sed -i "s/^ULIMIT=.*/ULIMIT=\"-n 4096\"/" /etc/default/nginx',
  subscribe => File['/etc/default/nginx'],
  notify    => Service['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  subscribe  => Exec['set_nginx_ulimit'],
}
