class composer () {
	
	exec { 'curl-install' :
		command => "sudo apt-get install curl",
		require => Exec["apt-get update"]
	}

	exec { 'composer-install' :
		command => "curl -sS https://getcomposer.org/installer | php",
		require => Exec["curl-install"]
	}

	exec { 'composer-global' :
		command => "mv composer.phar /usr/local/bin/composer",
		require => Exec["composer-install"]
	}
    notify { "Composer installation: Done!" : 
    	loglevel => 'notice',
    	require => Exec["composer-global"]
    }
}