class drush () {
	
	exec { 'drush-install' :
		command => "sudo apt-get install drush -y",
		require => Exec["composer-global"]
	}

    notify { "Drush installation: Done!" : 
    	loglevel => 'notice',
		require => Exec["drush-install"]
    }
}
