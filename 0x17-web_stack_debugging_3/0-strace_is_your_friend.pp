# replace erroneous .phpp extension line 137 with .php
# the error is the line require_once( ABSPATH . WPINC . '/class-wp-locale.phpp');
# in the file /var/www/html/wp-settings.php
# using puppet
file { '/var/www/html/wp-settings.php':
  ensure => present,
}

exec { 'replace_phpp_with_php':
  command => "sed -i 's/\\.phpp/.php/g' /var/www/html/wp-settings.php",
  path    => '/usr/bin:/bin', # Ensure sed is found in the PATH
}
