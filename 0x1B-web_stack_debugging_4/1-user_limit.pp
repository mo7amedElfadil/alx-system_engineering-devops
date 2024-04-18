# user limits
file { '/etc/security/limits.conf':
  ensure => present,
  notify => Exec['soft limit', 'hard limit'],
}

exec { 'soft limit':
  command  => "/bin/sed -i 's/^holberton soft nofile.*/holberton soft nofile 65536/' /etc/security/limits.conf",
}

exec { 'hard limit':
  command  => "/bin/sed -i 's/^holberton hard nofile.*/holberton hard nofile 65536/' /etc/security/limits.conf",
}
