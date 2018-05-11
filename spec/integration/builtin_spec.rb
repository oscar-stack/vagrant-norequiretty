require 'spec_helper'

describe VagrantNoRequireTTY::Plugin do
  let(:plugin_manager) { Vagrant::Plugin::V2::Plugin.manager }

  it 'is registered with the Vagrant plugin manager' do
    expect(plugin_manager.registered).to include(described_class)
  end

  describe 'when an action chain includes SyncedFolders' do
    let(:sync_action) { Vagrant::Action::Builtin::SyncedFolders }
    let(:action_procs) { plugin_manager.action_hooks(:test_action) }
    let(:hooks) do
      action_procs.map do |action_proc|
        Vagrant::Action::Hook.new.tap do |hook|
          action_proc.call(hook)
        end
      end
    end

    subject do
      builder = Vagrant::Action::Builder.build(sync_action)

      builder.to_app(action_hooks: hooks)
    end

    it 'hooks NoRequireTTY in after the SyncedFolder action' do
      sync_position = subject.actions.find_index {|a| a.is_a?(sync_action)}

      expect(subject.actions[sync_position + 1]).to be_a(VagrantNoRequireTTY::Action)
    end
  end
end
