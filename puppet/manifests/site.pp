node 'rabbit-1.local' {
  class { 'rabbitmq':
    repos_ensure  => true,
  }
}

node 'rabbit-2.local' {
  class { 'rabbitmq':
    repos_ensure  => true,
  }
}

node 'rabbit-3.local' {
  class { 'rabbitmq':
    repos_ensure  => true,
  }
}
