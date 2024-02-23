# Using Puppet, create a manifest that kills a process named killmenow
# and ensures that it is not running.

exec { 'killmenow':
  command => 'pkill killmenow',
  onlyif  => 'pgrep killmenow',
  path    => '/usr/bin',
}
