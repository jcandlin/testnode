class tomcat {

    $serviceName = 'tomcat'
    $appName = 'testapp'
    $tomcatVersion = '7.0.37'
    $deploymentEnvironment = 'testnode'

    $nexus = 'http://maven.apps.local:8082/nexus/content/repositories/releases/org/apache/tomcat'
    $tomcatURL = "$nexus/apache-tomcat/$tomcatVersion/apache-tomcat-$tomcatVersion.tar.gz"

    #Tomcat User
        group {'tomcat':
            ensure  => present,
            gid     => 500,
        }

        user {'tomcat_usr':
            ensure      => present,
            uid         => 500,
            home        => "/home/tomcat",
            require     => Group['tomcat'],
        }

    #Set Tomcat Directories
        file { '/opt/tomcat':
            ensure  => 'directory',
            owner   => 'tomcat_usr',
            group   => 'tomcat',
            recurse => true,
            mode    => '750',
        }	

        file { '/var/log/tomcat':
            ensure  => 'directory',
            owner   => 'tomcat_usr',
            group   => 'tomcat',
            recurse => true,
            mode    => '750',
        }

        file { "/var/log/tomcat/$serviceName$appName":
            ensure  => 'directory',
            owner   => 'tomcat_usr',
            group   => 'tomcat',
            recurse => true,
            mode    => '770',
            require => File['/var/log/tomcat'],
        }

        file { '/var/tomcat/logs':
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

#    #Hosts File Entries
#        class hostsDev { 
#            host { 'testnode':
#                ip => '192.168.33.21',
#                host_aliases => [ 'testnode.prod.williamhill.co.uk' ],
#            }
#        }

#        case $deploymentEnvironment {
#            'testnode': { include 'hostsDev' }
#        }
      