# frozen_string_literal: true

require 'spec_helper'

describe 'bareos_exporter' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'bareos_exporter class without any parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('bareos_exporter::params') }
        it { is_expected.to contain_class('bareos_exporter::install').that_comes_before('Class[bareos_exporter::service]') }
        it { is_expected.to contain_class('bareos_exporter::service') }

        it do
          is_expected.to contain_archive('/tmp/bareos_exporter-1.0.2.linux-amd64.tar.gz').with(
            'source'  => 'https://github.com/b1-systems/bareos_exporter/releases/download/v1.0.2/bareos_exporter-v1.0.2-linux-amd64.tar.gz',
            'creates' => '/opt/bareos_exporter-1.0.2/bareos_exporter'
          )
        end

        it { is_expected.to contain_service('bareos_exporter') }
      end

      context 'bareos_exporter class with parameters' do
        let(:params) do
          {
            manage_user: true,
            manage_group: true,
            bareos_exporter_user: 'bareos',
            bareos_exporter_group: 'bareos',
          }
        end

        it do
          is_expected.to compile.with_all_deps

          is_expected.to contain_user('bareos')
          is_expected.to contain_group('bareos')
        end
      end
    end
  end
end
