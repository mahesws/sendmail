class sendmail::service {
  service { $sendmail::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => true,
    require    => Class['sendmail::config'],
  }
}
