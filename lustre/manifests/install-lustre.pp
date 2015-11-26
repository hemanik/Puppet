class install_lustre{

  file{ "/etc/yum.repos.d/lustre.repo":
     path  => "/etc/yum.repos.d/lustre.repo",
     ensure  =>  file,
     content =>  template('lustre/lustre_repo.erb')
  }
  ->
  exec{ "yum clean":
     path => "/usr/bin:/bin",
     command => "yum clean all"
  }
  ->
  exec{ "yum update":
     path => "/usr/bin:/bin",
     command => "yum -y update",
     timeout => 350
  }
  ->
  exec{ "yum install lustre-tests":
     path => "/usr/bin:/bin",
     command => "yum -y install lustre-tests"
  }
  ->
  exec{ "yum install grub2-tools":
     path => "usr/bin:/bin",
     command => "yum -y install grub2-tools.x86_64"
  }
  ->
  exec{ "config grub2-tools":
     path => "usr/bin:/bin:/sbin",
     command => "grub2-mkconfig -o /boot/grub2/grub.cfg"
  }
  ->
  file{ "/etc/hosts":
     path => "/etc/hosts",
     ensure  => present,
     content => template('lustre/etc_hosts.erb')
  }
  ->
  notify{'rebooting': message => 'rebooting!',}
  ->
  exec{ "reboot":
     path => "/usr/bin:/bin",
     command => '/sbin/reboot',
  }

}

include install_lustre

