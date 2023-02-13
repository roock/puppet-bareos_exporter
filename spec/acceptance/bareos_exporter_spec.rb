# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bareos_exporter class' do
  context 'default parameters' do
    it 'idempotently with no errors' do
      pp = <<-EOS

      class { 'postgresql::globals':
        manage_package_repo => true,
        version             => '13',
      }
      -> class { 'postgresql::server':
        listen_addresses => '*',
      }
      # Backup access
      postgresql::server::role { 'bareos':
        password_hash => postgresql_password('bareos', 'ParpEyff-od2civCeif_onnOv6Tegud-Randaf1'),
        superuser     => true,
      }
      postgresql::server::pg_hba_rule { 'backup':
        description => 'Bacula Backup User',
        type        => 'host',
        database    => 'all',
        user        => 'bareos',
        address     => '127.0.0.1/16',
        auth_method => 'md5',
      }

      class { '::bareos':
        repo_release => '20', # Highly recommend to fix your bareos release. Defaults to 'latest'
        manage_repo  => true, # use the internally shipped repo management
      }

      # Install and configure an Director Server
      $storage_password = 'Password of the storage instance'

      class { '::bareos::profile::director':
        password         => 'Password of the director instance itself',
        catalog_conf     => {
          'db_driver'   => 'postgresql',
          'db_name'     => 'bareos',
          'db_address'  => '127.0.0.1',
          'db_port'     => 5432,
          'db_user'     => 'bareos',
          'db_password' => 'ParpEyff-od2civCeif_onnOv6Tegud-Randaf1'
        },
        storage_address  => 'localhost',
        storage_password => $storage_password,
      }

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

      class { '::bareos_exporter':
        manage_user           => false,
        manage_group          => false,
        bareos_exporter_user  => 'postgres',
        bareos_exporter_group => 'postgres',
      }

      EOS

      result = apply_manifest(pp, catch_failures: true)

      # gitlab-ctl reconfigure emits a warning if the LD_LIBRARY_PATH
      # is set, even if it is empty.
      expect(result.stdout).not_to match(%r{LD_LIBRARY_PATH was found})

      apply_manifest(pp, catch_changes: true)

      shell('sleep 15') # give it some time to start up
    end

    describe command('curl -s -S http://127.0.0.1:9625/metrics') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{.*bareos_jobs_run.*} }
    end
  end
end
