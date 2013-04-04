class maven {

  require wget

  file { '/tmp/apache-maven-3.0.5-bin.tar.gz':
    ensure => present,
    require => Exec['Fetch maven'],
  }

  exec { 'Fetch maven':
    cwd => '/tmp',
    command => 'wget http://apache.komsys.org/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz',
    creates => '/tmp/apache-maven-3.0.5-bin.tar.gz',
    path    => ['/opt/boxen/homebrew/bin'];
  }

  exec { 'Extract maven':
    cwd     => '/usr/local',
    command => 'tar xvf /tmp/apache-maven-3.0.5-bin.tar.gz',
    creates => '/usr/local/apache-maven-3.0.5',
    path    => ['/usr/bin'],
    require => Exec['Fetch maven'];
  }

  file { '/usr/local/apache-maven-3.0.5':
    require => Exec['Extract maven'];
  }

  file { '/usr/local/maven':
    ensure  => link,
    target  => '/usr/local/apache-maven-3.0.5',
    require => File['/usr/local/apache-maven-3.0.5'];
  }
  
  file { '/opt/boxen/bin/mvn': 
    ensure => link,
    target  => '/usr/local/maven/bin/mvn',
    require => File['/usr/local/maven'];
  }

}
