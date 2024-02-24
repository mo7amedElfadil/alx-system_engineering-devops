# configure puppet to make changes to our configuration files
# set up client SSH config to connect to server without password
# SSH client configuration must be configured to use the private key ~/.ssh/school
# SSH client configuration must be configured to refuse to authenticate using a password

# Client configuration file
file_line { 'Disable password authentication':
  ensure => present,
  line   => 'PasswordAuthentication no',
  path   => '/etc/ssh/ssh_config',
  match  => '^\s*#?\s*PasswordAuthentication',
}

file_line { 'Use private key for authentication':
  ensure => present,
  line   => 'IdentityFile ~/.ssh/school',
  path   => '/etc/ssh/ssh_config',
  match  => '^\s*#?\s*IdentityFile ~/.ssh/school',
}
