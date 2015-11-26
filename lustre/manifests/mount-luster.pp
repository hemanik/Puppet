class mount_lustre{

   notify{'Mount Lustre': message => 'Mounting lustre file system!',}
   -> 
   exec{ "mount lustre":
      path => "/usr/bin:/bin:/sbin",
      command => '/usr/lib64/lustre/tests/llmount.sh'
   }

}

include mount_lustre
