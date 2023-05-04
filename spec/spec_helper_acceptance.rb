# frozen_string_literal: true

require 'voxpupuli/acceptance/spec_helper_acceptance'

configure_beaker do |host|
  # Install testing only dependencies, not specified in metadata
  install_module_from_forge('puppetlabs/apt', '>= 9.0.0')
  install_module_from_forge('puppetlabs/postgresql', '>= 8.0.0')

  pp = %(
    class { 'postgresql::globals':
      manage_package_repo => true,
      version             => '15',
    }
    -> class { 'postgresql::server':
      listen_addresses => '*',
    }

    postgresql::server::db { 'bareos':
      user     => 'bareos',
      password => postgresql::postgresql_password('bareos', 'bareos'),
    }

#    # Backup access
#    postgresql::server::role { 'bareos':
#      password_hash => postgresql_password('bareos', 'ParpEyff-od2civCeif_onnOv6Tegud-Randaf1'),
#      superuser     => true,
#    }
#    postgresql::server::pg_hba_rule { 'backup':
#      description => 'Bacula Backup User',
#      type        => 'host',
#      database    => 'all',
#      user        => 'bareos',
#      address     => '127.0.0.1/16',
#      auth_method => 'md5',
#    }
#
#    class { '::bareos':
#      #repo_release => 'latest', # Highly recommend to fix your bareos release. Defaults to 'latest'
#      repo_release => '21', # Highly recommend to fix your bareos release. Defaults to 'latest'
#      manage_repo  => true, # use the internally shipped repo management
#      director_package_name => [
#        'bareos-director',
#        'bareos-director-python3-plugin',
#        'bareos-database-common',
#        'bareos-database-postgresql',
#        'bareos-database-tools',
#      ],
#      client_package_name => ['bareos-filedaemon', 'bareos-filedaemon-python3-plugin']
#    }

#    # Install and configure an Director Server
#    $storage_password = 'Password of the storage instance'
#
#    class { '::bareos::profile::director':
#      password         => 'Password of the director instance itself',
#      catalog_conf     => {
#        'db_driver'   => 'postgresql',
#        'db_name'     => 'bareos',
#        'db_address'  => '127.0.0.1',
#        'db_port'     => 5432,
#        'db_user'     => 'bareos',
#        'db_password' => 'ParpEyff-od2civCeif_onnOv6Tegud-Randaf1'
#      },
#      storage_address  => 'localhost',
#      storage_password => $storage_password,
#    }

    # add storage server to the same machine
    #class { '::bareos::profile::storage':
    #  password       => $storage_password,
    #  archive_device => '/var/lib/bareos/storage',
    #}

    # add the client to the config
    #::bareos::director::client { 'bareos-client':
    #  description => 'Your fancy client to backup',
    #  password    => 'MyClientPasswordPleaseChange',
    #  address     => 'fqdn',
    #}

    # Create an backup job by referencing to the jobDef template.
    #::bareos::director::job { 'backup-bareos-client':
    #  job_defs => 'LinuxAll',
    #  client   => 'bareos-client', # which client to assign this job
    #}

    #package { ['curl']:
    #  ensure => present,
    #}

  )

  apply_manifest_on(host, pp, catch_failures: false)

  apply_manifest_on(host, pp, catch_failures: true)

  # https://gitlab.com/gitlab-org/omnibus-gitlab/issues/2229
  # There is no /usr/share/zoneinfo in latest Docker image for ubuntu 16.04
  # Gitlab installer fail without this file
  # tzdata = %(
  #  package { ['tzdata']:
  #    ensure => present,
  #  }
  # )

  # apply_manifest_on(host, tzdata, catch_failures: true) if fact('os.release.major') =~ %r{(16.04|18.04)}
end

require 'beaker/module_install_helper'
