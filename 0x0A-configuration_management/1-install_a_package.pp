# class to install python3, pip3, werkzeug and flask
class myapp::install {

# install python3
  package { 'python3':
    ensure => 'installed',
  }

# install pip3
  package { 'python3-pip':
    ensure => 'installed',
  }

# install werkzeug
  package { 'werkzeug':
    ensure   => '2.1.1',
    provider => 'pip3',
  }


# install Flask
  package { 'flask':
    ensure   => '2.1.0',
    provider => 'pip3',
  }
}
node default {
  include myapp::install
}
