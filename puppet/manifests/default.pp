Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

exec { "apt-update":
  command => "/usr/bin/apt-get update"
}
Exec["apt-update"] -> Package <| |>

file { "/usr/local/bin":
  owner => "vagrant",
  group => "vagrant",
  recurse => true
}


user { "vagrant":
  ensure => present,
  shell  => "/bin/bash"
}


include thmcards