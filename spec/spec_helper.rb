$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Disable Vagrant autoloading so that tests don't clash with any Vagrant
# install that happens to be present. Plugins are loaded manually below.
ENV['VAGRANT_NO_PLUGINS'] = '1'
ENV['VAGRANT_DISABLE_PLUGIN_INIT'] = '1'

require 'vagrant'
require 'vagrant/action'
require 'vagrant/action/hook'
require 'vagrant/plugin/v2/plugin'

require 'vagrant-norequiretty'
require 'vagrant-norequiretty/action'

require 'vagrant-openstack-provider'
require 'vagrant-openstack-provider/action/sync_folders'
