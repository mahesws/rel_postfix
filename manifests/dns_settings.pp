class rel_postfix::dns_settings (
 $dns_native_lookup_enable
) {

if($dns_native_lookup_enable) {
rel_postfix::maincf::param {'smtp_host_lookup':
 value => 'dns, native'
}

rel_postfix::maincf::param { 'smtp_dns_support_level':
 value => 'enabled'  
}
}
else
{
exit
}
} 
