exec    { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }

class bootstrap {

    host { 'testnode.prod.williamhill.plc':
        ensure       => 'present',
        host_aliases => ['testnode'],
        ip           => '192.168.33.21',
        target       => '/etc/hosts',
  }

    host { 'puppet.prod.williamhill.plc':
        ensure       => 'present',
        host_aliases => ['puppet'],
        ip           => '192.168.33.20',
        target       => '/etc/hosts',
  }

    file {'/etc/puppet/puppet.conf':
        ensure => present,
        owner => root,
        group => root,
        source => "/vagrant/puppet/puppet.conf",
  }

    file {'/etc/puppet/auth.conf':
        ensure => present,
        owner => root,
        group => root,
        source => "/vagrant/puppet/auth.conf",
  }
}