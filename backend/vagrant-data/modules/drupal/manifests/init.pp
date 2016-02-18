class drupal () {
	
	
	file { 'drupal_composer' :
		path    => '/var/www/public/composer.json',
		source  => '/vagrant/vagrant-data/modules/drupal/files/composer.json',
   		require => Exec["drush-install"]
	}

	#file { 'drupal_index' :
	#	path    => '/var/www/public/d7/index.php',
	#	source  => '/vagrant/vagrant-data/modules/drupal/files/index.php',
   	#	require => File['drupal_composer']
	#}

	#file { 'drupal_config' :
	#	path    => '/var/www/public/d7/sites/default/settings.php',
	#	source  => '/vagrant/vagrant-data/modules/drupal/files/settings.php',
   	#	require => File['drupal_index']
	#}

	exec { 'drupal_download' :
		command => "sudo -u vagrant drush dl drupal --drupal-project-rename=d7",
		cwd => '/var/www/public',
		require  => File["drupal_composer"]
	}

	exec { 'drupal_core_install' :
		command => "sudo drush site-install --db-url=mysql://root:root@localhost:3306/d7_composer --site-name=D7_Composer_template -y",
		cwd => '/var/www/public/d7',
		require  => Exec["drupal_download"]
	}

	exec { 'composer_install' :
		command => "sudo composer install",
		cwd => '/var/www/public',
		require  => Exec["drupal_core_install"]
	}
	
    notify { "Drupal... installation: Done!" : 
    	loglevel => 'notice',
    	require => Exec["composer_install"]
    }
}