# @api private
# @summary manage the postfix system service
class rel_postfix::service {
  $manage_service = $::rel_postfix::manage_service
  $ensure_service = $::rel_postfix::ensure_service
  $enable_service = $::rel_postfix::enable_service
  $service_name = $::rel_postfix::install::service_name

  if( $manage_service ) {
    service { $service_name:
      ensure => $ensure_service,
      enable => $enable_service,
    }
  }
}
