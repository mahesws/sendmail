class sendmail::config(
$sendmail_mc_path, 
$sendmail_service_name,
$sendmail_smarthost,
){
   file { $sendmail_mc_path:
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => epp('sendmail/sendmailmc.epp'),
        notify  => Exec["make_sendmail_config"],
    }
   
    exec { "make_sendmail_config" :
        command     => 'make -C /etc/mail',
        path        => [ "/bin", "/usr/bin" ],
        cwd         => '/etc/mail',
        refreshonly => true,
        notify      => Service[$sendmail_service_name],
    }
}
