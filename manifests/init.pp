# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include rel_postfix
class rel_postfix (
  $manage_install = $::rel_postfix::defaults::manage_install,
  $manage_service = $::rel_postfix::defaults::manage_service,
  $ensure_service = $::rel_postfix::defaults::ensure_service,
  $enable_service = $::rel_postfix::defaults::enable_service,
  $install_source = $::rel_postfix::defaults::install_source,
  $package_name = $::rel_postfix::defaults::package_name,
  $manage_maincf = $::rel_postfix::defaults::manage_maincf,
  $manage_mastercf = $::rel_postfix::defaults::manage_mastercf,
  $manage_mynetworks = $::rel_postfix::defaults::manage_mynetworks,
  $manage_aliases = $::rel_postfix::defaults::manage_aliases,
  $version = $::rel_postfix::defaults::version,

  # main.cf options
  $myorigin = $::rel_postfix::defaults::myorigin,
  $smtpd_banner = $::rel_postfix::defaults::smtpd_banner,
  $smtpd_relay_restrictions = $::rel_postfix::defaults::smtpd_relay_restrictions,
  $myhostname = $::rel_postfix::defaults::myhostname,
  $mydestination = $::rel_postfix::defaults::mydestination,
  $mynetworks = $::rel_postfix::defaults::mynetworks,
  $inet_interfaces = $::rel_postfix::defaults::inet_interfaces,
  $inet_protocols = $::rel_postfix::defaults::inet_protocols,
  $mydomain = $::rel_postfix::defaults::mydomain,
  $local_transport = $::rel_postfix::defaults::local_transport,
  $relayhost = $::rel_postfix::defaults::relayhost,
  $dns_native_lookup_enable = $::rel_postfix::defaults::dns_native_lookup_enable,
) inherits rel_postfix::defaults {
class { 'rel_postfix::install': }

class { 'rel_postfix::service': }

if( $manage_maincf ) {
 class { 'rel_postfix::maincf': }
}

class { 'rel_postfix::dns_settings':
 dns_native_lookup_enable => $dns_native_lookup_enable
}   
}
