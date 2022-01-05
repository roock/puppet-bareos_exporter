#
# @api private
#
# @summary Parameter Class from bareos exporter
class bareos_exporter::params {
  $version                       = '1.0.2'
  $manage_user                   = false
  $manage_group                  = false
  $archive_url_base              = 'https://github.com/b1-systems/bareos_exporter/releases/download'
  $archive_name                  = 'bareos_exporter'
  $archive_url                   = undef
  $bareos_exporter_user          = 'postgres'
  $bareos_exporter_group         = 'postgres'
  $bareos_exporter_datasource    = 'user=postgres host=/var/run/postgresql/ sslmode=disable'
  $bareos_exporter_dbtype        = 'pgx'
  $bareos_exporter_port          = '9625'


  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    default: {
      fail("${::architecture} unsuported")
    }
  }
  case $::kernel {
    'Linux': { $os = downcase($::kernel)}
    default: {
      fail("${::kernel} not supported")
    }
  }
}
