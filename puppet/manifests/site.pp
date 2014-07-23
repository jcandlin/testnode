Exec {
    path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"]
}

exec    { 'apt-get update':
        command => '/usr/bin/apt-get update'
}

node testnode {
	include bootstrap
    include tools
    include tomcat
}