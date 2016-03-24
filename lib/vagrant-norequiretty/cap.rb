class VagrantNoRequireTTY::Cap

  # @return [void]
  def self.norequiretty(machine)
    old_pty_setting = machine.config.ssh.pty
    machine.config.ssh.pty = true

    machine.ui.info ("Ensuring requiretty is disabled...")
    machine.communicate.sudo(<<-'EOS', pty: true)
sed -i'.bk' -e 's/^\(Defaults\s\+requiretty\)/# \1/' /etc/sudoers
EOS
  ensure
    machine.config.ssh.pty = old_pty_setting
  end

end
