require 'spec_helper'

describe VagrantPlugins::Openstack::Action::SyncFolders do
  let(:plugin_manager) { Vagrant::Plugin::V2::Plugin.manager }

  describe 'when an action chain includes OpenStack SyncFolders' do
    let(:action_procs) { plugin_manager.action_hooks(:test_action) }
    let(:hooks) do
      action_procs.map do |action_proc|
        Vagrant::Action::Hook.new.tap do |hook|
          action_proc.call(hook)
        end
      end
    end

    subject do
      builder = Vagrant::Action::Builder.build(described_class)

      builder.to_app(action_hooks: hooks)
    end

    it 'hooks NoRequireTTY in after the Openstack SyncFolder action' do
      sync_position = subject.actions.find_index {|a| a.is_a?(described_class)}

      expect(subject.actions[sync_position + 1]).to be_a(VagrantNoRequireTTY::Action)
    end
  end
end
