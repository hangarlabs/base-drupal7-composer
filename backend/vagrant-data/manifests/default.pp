Exec {
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec { 'apt-get update':
    command   => '/usr/bin/apt-get update',
    subscribe => Exec["nameserver"],
}

exec { 'nameserver':
	 command => 'echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null'
}

package { 'python-software-properties' :
	ensure  => 'present',
	require => Exec["apt-get update"],
}


class { 'apache' :
    servername => "localhost",
}

class { 'mysql' :
  	user     => "root",
  	password => "root",
  	database => "d7_composer",
}

class { 'php' : 
	# Add this repo to have PHP 5.6
	repository => "ppa:ondrej/php5-5.6",
}

class { 'composer' : }

class { 'drush' : }

class { 'sendmail' : }

class { 'drupal' : }