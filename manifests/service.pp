#
# @api private
#
# @summary This class handles the creation of systemd service and its autostart Avoid modifying private classes.
#
#
class bareos_exporter::service {
  # this is a private class
  assert_private("You're not supposed to do that!")

  file { '/etc/systemd/system/bareos_exporter.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('bareos_exporter/bareos_exporter.systemd.epp',
      {
        'bin_dir' => $bareos_exporter::install::install_dir
      }
    ),
  }
  ~>exec { 'systemctl-daemon-reload-bareos_exporter':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }
  ->service { 'bareos_exporter':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
