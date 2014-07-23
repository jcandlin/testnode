class tools {

    package { ["tar"]:
            ensure => installed,         
    }

    package { ["unzip"]:
            ensure => installed,         
    }
    
    package { ["openjdk-7-jre-headless"]:
            ensure => installed,             
    }

    package { 'git-core' :
        ensure => 'latest',
    }
  
    package { "build-essential":
        ensure => present,
    }  

    package { "libopenssl-ruby":
        ensure => present,
    }  

    package { "ruby1.9.1-full":
        ensure => present,
    }  
}

