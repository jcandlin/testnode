Exec {
    path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"]
}

node testnode {
    include bootstrap
    include tools
}