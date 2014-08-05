class thmcards {
  $base_path = "/vagrant"


  package { "couchdb": ensure => "latest" }

  service { "couchdb":
    ensure => "running",
    enable => true,
    require => Package["couchdb"]
  }

  file { "/etc/thmcards":
    ensure => "directory"
  }

  file { "/home/vagrant/start.sh":
    owner => "vagrant",
    group => "vagrant",
    content => template("thmcards/start.sh.erb"),
    mode => "744"
  }

  couchdb { "couchdb-host-access":
    notify => Service["couchdb"],
  }

  class { "motd":
    template => "thmcards/motd.erb"
  }  
  


  exec { "initialize-couchdb":
    cwd => "$base_path",
    # CouchDB uses delayed commits, so wait a few seconds to ensure documents are written to disk
    command => "/bin/sleep 5 && /usr/bin/python createviews.py && /bin/sleep 5",
    user => "vagrant"
  }

  exec { "install-nodedeps":
    cwd => "$base_path",
    command => "/usr/bin/npm install --no-bin-links",
    user => "vagrant"
  }


}