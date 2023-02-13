# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bareos_exporter class' do
  context 'default parameters' do
    it 'idempotently with no errors' do
      pp = <<-EOS

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
      its(:stdout) { is_expected.to match %r{.*promhttp_metric_handler_requests_total.*} }
    end
  end
end
