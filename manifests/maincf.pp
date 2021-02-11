# @summary manage postfix main.cf
class rel_postfix::maincf (
  $ensure = 'present',
  $smtpd_banner = $::rel_postfix::smtpd_banner,
  $myhostname = $::rel_postfix::myhostname,
  $myorigin = $::rel_postfix::myorigin,
  $inet_interfaces = $::rel_postfix::inet_interfaces,
  $inet_protocols = $::rel_postfix::inet_protocols,
  $mydestination = $::rel_postfix::mydestination,
  $mynetworks = $::rel_postfix::mynetworks,
  $mydomain = $::rel_postfix::mydomain,
  $relayhost = $::rel_postfix::relayhost,
) {
  $etc_dir = $::rel_postfix::install::etc_dir
  $path = "${etc_dir}/main.cf"
  $manage_service = $::rel_postfix::manage_service
  $service_name = $::rel_postfix::install::service_name
  $have_postfix_3_0 = $::rel_postfix::have_postfix_3_0

  concat { $path:
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
  if( $manage_service ) {
    Concat[$path] ~> Service[$service_name]
  }
  concat::fragment{ "${path}-head":
    target  => $path,
    content => template('rel_postfix/maincf/head.erb'),
    order   => '01'
  }
  concat::fragment{ "${path}-parameters":
    target  => $path,
    content => template('rel_postfix/maincf/parameters.erb'),
    order   => '02'
  }
}
