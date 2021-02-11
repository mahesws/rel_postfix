# @api public
# @summary creates an parameter in the main.cf configuration
#
# @example Basic usage
#
#   rel_postfix::maincf::param { 'smptd_banner':
#     value => 'unknown'
#   }
#
# @param value
#   The value for the configuration parameter.
# @param comment
#   An optional comment to include in the main.cf.
# @param order
#   Allows to specify an priority for ordering.
define rel_postfix::maincf::param (
  $value,
  $comment = undef,
  $order = 50,
) {
  $maincf_path = $::rel_postfix::maincf::path

  concat::fragment{ "${maincf_path}-${name}":
    target  => $maincf_path,
    content => template('rel_postfix/maincf/param.erb'),
    order   => $order,
  }
}
