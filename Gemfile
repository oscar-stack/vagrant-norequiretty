source 'https://rubygems.org'
require 'rubygems/version'

vagrant_branch = ENV['TEST_VAGRANT_VERSION'] || 'v2.2.2'
vagrant_version = nil

group :plugins do
  gemspec
  gem 'vagrant-openstack-provider',             '~> 0.12.0'
end

group :test do
  case vagrant_branch
  when /head/i
    gem 'vagrant', :git => 'https://github.com/hashicorp/vagrant.git',
      :branch => 'master'
  else
    vagrant_version = Gem::Version.new(vagrant_branch.sub(/^v/, ''))
    gem 'vagrant', :git => 'https://github.com/hashicorp/vagrant.git',
      :tag => vagrant_branch
  end

  if vagrant_branch.match(/head/i) || (vagrant_version >= Gem::Version.new('1.9'))
    # Pinned on 5/10/2018. Compatible with Vagrant >= 1.9 and brings in RSpec 3
    gem 'vagrant-spec', :git => 'https://github.com/hashicorp/vagrant-spec.git',
      :ref => '9413ab2'
  end
  gem 'rake'
end

eval_gemfile "#{__FILE__}.local" if File.exists? "#{__FILE__}.local"
