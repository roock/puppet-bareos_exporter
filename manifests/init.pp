# bareos_exporter
#
# @summary Main class, includes all other classes
#
# @example
#   include bareos_exporter
#
# @param version
#   Which version to install
# @param manage_user
#   Whether to create the bareos_exporter user. Must be created by other means if set to false
# @param manage_group
#   Whether to create the bareos_exporter group. Must be created by other means if set to false
# @param bareos_exporter_user
#   whether to create the user. Default is postgres
# @param bareos_exporter_group
#   whether to create the group. Default is postgres
# @param datasource
#   the url connection to postgres. Default is local "user=postgres host=/var/run/postgresql/ sslmode=disable"
# @param dbtype
#   the type of database connection to use # FIXME provide example
# @param port
#   he port on which the service is expose
class bareos_exporter (
  Optional[String] $version = $::bareos_exporter::params::version,
  Optional[Boolean] $manage_user = $::bareos_exporter::params::manage_user,
  Optional[Boolean] $manage_group = $::bareos_exporter::params::manage_group,
  Optional[String] $bareos_exporter_user = $::bareos_exporter::params::bareos_exporter_user,
  Optional[String] $bareos_exporter_group = $::bareos_exporter::params::bareos_exporter_group,
  Optional[String] $datasource = $::bareos_exporter::params::bareos_exporter_datasource,
  Optional[String] $dbtype = $::bareos_exporter::params::bareos_exporter_dbtype,
  Optional[String] $port = $::bareos_exporter::params::bareos_exporter_port,
) inherits bareos_exporter::params {
  class { '::bareos_exporter::install': }
  ~> class {'::bareos_exporter::service': }
}
