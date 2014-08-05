include thmcards

# Ensure the repository is updated before any package is installed
#exec { "apt-update":
#  command => "/usr/bin/apt-get update"
#}
#Exec["apt-update"] -> Package <| |>

# Strangely, bash is not the default...
user { "vagrant":
  ensure => present,
  shell  => "/bin/bash"
}