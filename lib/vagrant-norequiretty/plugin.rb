require 'vagrant'
require 'vagrant-norequiretty'

class VagrantNoRequireTTY::Plugin < Vagrant.plugin(2)
  name 'norequiretty'

  description <<-DESC
  This plugin adds one provisioner, norequiretty, which EnDs tHE mADneSssss..

  https://bugzilla.redhat.com/show_bug.cgi?id=1020147
  DESC

  action_hook('Disable requiretty') do |hook|
    require_relative 'action'
    action = VagrantNoRequireTTY::Action

    # For RSync.
    hook.after(Vagrant::Action::Builtin::SyncedFolders, action)
  end

  # For everything else.
  action_hook('Disable requiretty on shutdown', :machine_action_halt) do |hook|
    require_relative 'action'
    action = VagrantNoRequireTTY::Action

    hook.prepend(action)
  end

  action_hook('Disable requiretty on reload', :machine_action_reload) do |hook|
    require_relative 'action'
    action = VagrantNoRequireTTY::Action

    hook.prepend(action)
  end

  action_hook('Disable requiretty on destroy', :machine_action_destroy) do |hook|
    require_relative 'action'
    action = VagrantNoRequireTTY::Action

    hook.prepend(action)
  end

  # For great justice.


  [:linux].each do |os|
    guest_capability(os, :norequiretty) do
      require_relative 'cap'
      VagrantNoRequireTTY::Cap
    end
  end

end