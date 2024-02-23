# This is a simple example of a Puppet file resource
# The file resource is used to manage files on the system
# path /tmp/school
# contain the text "I love Puppet"
# owned by the user www-data and the group www-data
# permissions 0744

file { '/tmp/school':
  ensure  => 'file',
  content => 'I love Puppet',
  path    => '/tmp/school',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0744',
}
