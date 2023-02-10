#
# @api private
#
# @summary This class handles the download and installation of bareos exporter. Avoid modifying private classes.
#
# Downloads the bareos exporter from the Gitlab Release Page and extracts to `/opt`
#
class bareos_exporter::install {
  # this is a private class
  assert_private("You're not supposed to do that!")

  include archive

  if $bareos_exporter::manage_user {
    ensure_resource('user', [$bareos_exporter::bareos_exporter_user],
      {
        ensure => 'present',
        system => true,
      }
    )
  }

  if $bareos_exporter::manage_group {
    ensure_resource('group', [$bareos_exporter::bareos_exporter_group],
      {
        ensure => 'present',
        system => true,
      }
    )
    Group[$bareos_exporter::bareos_exporter_group] ->User[$bareos_exporter::bareos_exporter_user]
  }

  $real_archive_url = pick(
    $bareos_exporter::archive_url,
    "${bareos_exporter::archive_url_base}/v${bareos_exporter::version}/${bareos_exporter::archive_name}-v${bareos_exporter::version}-${bareos_exporter::os}-${bareos_exporter::arch}.tar.gz" # lint:ignore:140chars
  )
  $local_archive_name = "${bareos_exporter::archive_name}-${bareos_exporter::version}.${bareos_exporter::os}-${bareos_exporter::arch}.tar.gz" # lint:ignore:140chars
  $install_dir = "/opt/${bareos_exporter::archive_name}-${bareos_exporter::version}"

  file { $install_dir:
    ensure => directory,
    owner  => root,
    group  => root,
  }

  archive { "/tmp/${local_archive_name}":
    ensure          => present,
    extract         => true,
    extract_path    => $install_dir,
    source          => $real_archive_url,
    checksum_verify => false,
    creates         => "${install_dir}/bareos_exporter",
    cleanup         => true,
  }
}
