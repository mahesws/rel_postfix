# @api private
# @summary manage postfix installation
class rel_postfix::install {
  $manage_install = $::rel_postfix::manage_install
  $manage_service = $::rel_postfix::manage_service
  $install_source = $::rel_postfix::install_source
  $package_name = $::rel_postfix::package_name
  $etc_dir = '/etc/postfix'
  $aliases_file = '/etc/aliases'
  $service_name = 'postfix'
  $readme_directory = 'no'
  if( $manage_install ) {
    if( $install_source == 'vendor' ) {
      package { $package_name:
        ensure        => 'present',
        allow_virtual => false,
      }
      if( $manage_service ) {
        Package[$package_name] ~> Service[$service_name]
      }
    }
}
}
