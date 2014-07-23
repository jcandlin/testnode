class tomcat {

    $serviceName = 'tomcat'
    $appName = 'testapp'
    $tomcatVersion = '7.0.37'
    $deploymentEnvironment = 'testnode'

    $nexus = 'http://maven.apps.local:8082/nexus/content/repositories/releases/org/apache/tomcat'
    $tomcatURL = "$nexus/apache-tomcat/$tomcatVersion/apache-tomcat-$tomcatVersion.tar.gz"

    #Tomcat User & Group
        user { "tomcat" :
            managehome => true,
            ensure     => present,
        }

    #Set Tomcat Directories & Links
        file { '/opt/tomcat':
            ensure  => 'directory',
            owner   => 'tomcat',
            group   => 'tomcat',
            mode    => '750',
        }	

        file { '/var/log/tomcat':
            ensure  => 'directory',
            owner   => 'tomcat',
            group   => 'tomcat',
            mode    => '750',
        }

        file { "/var/log/tomcat/$serviceName$appName":
            ensure  => 'directory',
            owner   => 'tomcat',
            group   => 'tomcat',
            mode    => '770',
            require => File['/var/log/tomcat'],
        }

        file { '/opt/tomcat/logs':
            ensure => 'link',
            target => '/var/log/tomcat',
            require => [File['/var/log/tomcat'], File['/opt/tomcat']],
        }

    #Get Tomcat Archive
        exec { 'download-tomcat':
            command => "wget -O tomcat.tar.gz $tomcatURL",
        } 

    #Extract Tomcat Archive
        exec { 'extract-tomcat':
            command => 'tar -xvf tomcat.tar.gz -C /opt/tomcat/',
            require => [Exec['download-tomcat'],File['/opt/tomcat']],
        }
}  
      