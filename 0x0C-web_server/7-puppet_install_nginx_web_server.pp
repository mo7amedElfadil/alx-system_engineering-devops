# install nginx
package { 'nginx':
  ensure => 'installed',
}

# create a file with content
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello world!',
  require => Package['nginx'],
  mode    => '0644',
}
# modify the default nginx configuration
$new_string = "location /redirect_me {\\
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;\\
}"
exec { 'redirect_me':
  path    => ['/bin', '/usr/bin'],
  command => "sudo sed -i '/server_name _;/a ${new_string}' /etc/nginx/sites-available/default",
}
service {'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
