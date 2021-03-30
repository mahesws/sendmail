class sendmail (
  $manage_sendmail   = $sendmail::manage_sendmail,
  $manage_service    = $sendmail::manage_service,
  $sendmail_mc_path  = $sendmail::sendmail_mc_path,
  $sendmail_mc_templ = $sendmail::sendmail_mc_templ,
  $service_name      = $sendmail::service_name,
  $smarthost 	     = $sendmail::smarthost
) {
  $values = lookup('sendmail::server',Array[String],"first")
  notify{"The values ${values}" : }

  if $facts['networking']['fqdn'] in $values
  {
   notify{"${facts['networking']['fqdn']}": }
  
  if ($manage_sendmail) {
      class { 'sendmail::config':
	sendmail_mc_path      => $sendmail_mc_path,
        sendmail_service_name => $service_name,
        sendmail_smarthost    => $smarthost,        
   }
  }
  
  if ($manage_service) {
      class { 'sendmail::service': }
    }
  }
  else
  {
   notify{"This node is not having access to send mails to relayhost": }
  }
}
