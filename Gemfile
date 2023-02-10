source ENV['GEM_SOURCE'] || 'https://rubygems.org'


# The development group is intended for developer tooling. CI will never install this.
group :development do
end

# The test group is used for static validations and unit tests in gha-puppet's
# basic and beaker gha-puppet workflows.
# Consider using https://github.com/voxpupuli/voxpupuli-test
group :test do
  # Require the latest Puppet by default unless a specific version was requested
  # CI will typically set it to '~> 7.0' to get 7.x
  #gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '>= 0', require: false
  # Needed to build the test matrix based on metadata
  gem 'puppet_metadata', '~> 1.10',  require: false
  # Needed for the rake tasks
  gem 'puppetlabs_spec_helper', '>= 2.16.0', '< 5', require: false
  # Rubocop versions are also specific so it's recommended
  # to be precise. Can be turned off via a parameter
  gem 'rubocop', require: false

  gem 'voxpupuli-test', '~> 5.4',   :require => false
  gem 'coveralls',                  :require => false
  gem 'simplecov-console',          :require => false
end

# The system_tests group is used in gha-puppet's beaker workflow.
# Consider using https://github.com/voxpupuli/voxpupuli-acceptance
group :system_tests do
  gem 'voxpupuli-acceptance', '~> 1.0',  :require => false
  gem 'beaker', require: false
  gem 'beaker-docker', require: false
  gem 'beaker-rspec', require: false
end

# The release group is used in gha-puppet's release workflow
group :release do
  gem 'github_changelog_generator', '>= 1.16.1',  :require => false if RUBY_VERSION >= '2.5'
  gem 'voxpupuli-release', '>= 1.2.0',            :require => false
  gem 'puppet-strings', '>= 2.2',                 :require => false
end


gem 'rake', :require => false
gem 'facter', ENV['FACTER_GEM_VERSION'], :require => false, :groups => [:test]

puppetversion = ENV['PUPPET_GEM_VERSION'] || '>= 6.0'
gem 'puppet', puppetversion, :require => false, :groups => [:test]

# vim: syntax=ruby
