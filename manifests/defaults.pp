# @api private
# @summary provide default values for module parameters
class rel_postfix::defaults {
  $manage_install = true
  $manage_service = true
  $ensure_service = 'running'
  $enable_service = true
  $manage_maincf = true
  $dns_native_lookup_enable = true

  # for now this is the same for all supported distributions
  $install_source = 'vendor'
  $package_name = 'postfix'

  case $facts['os']['name'] {
    'Ubuntu': {
      $dist_version = $facts['os']['release']['major'] ? {
        '14.04' => '2.11.0',
        '16.04' => '3.1.0',
        '18.04' => '3.3.0',
      }
      $chroot = true
    }

    'Debian': {
      $dist_version = $facts['os']['release']['major'] ? {
        '8' => '3.1.9',
        '9' => '3.4.1',
      }
      $chroot = true
    }

    /^(RedHat|CentOS)$/: {
      $dist_version = $facts['os']['release']['major'] ? {
        '6' => '2.6.6',
        '7' => '2.10.1',
        '8' => '3.3.1',
      }
      $chroot = false
    }

    default: {
      fail('operating system not supported by module')
    }
  }

  # prefer version from fact obtained thru postconf -d mail_version
  # otherwise use the version shipped with the OS
  if( $facts['postfix_version'] ) {
    $version = $facts['postfix_version']
  } else {
    $version = $dist_version
  }

  # main.cf options
  $myorigin = $facts['fqdn']
  $smtpd_banner = "${::fqdn} ESMTP"
  $myhostname = $facts['fqdn']
  $mydestination = ['']
  $mynetworks = [
    '127.0.0.0/8',
    '[::ffff:127.0.0.0]/104',
    '[::1]/128',
  ]
  $inet_interfaces = 'loopback-only'
  $inet_protocols = 'ipv4'
  $mydomain = "pt.ms"
  $relayhost = '[sendmail.pt.ms]'
  $local_transport = 'this is a null client'
  #$disable_dns_lookups = 'yes'
  #$dns_native_lookup_enable = true
}
