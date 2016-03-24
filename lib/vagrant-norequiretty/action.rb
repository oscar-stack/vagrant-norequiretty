module VagrantNoRequireTTY
  class Action
    def initialize(app, env)
      @app = app
      @env = env
      @machine = env[:machine]
      @set = false
    end

    def call(env)
      # So nice, we call it twice.
      disable_requiretty!

      @app.call(env)

      disable_requiretty!
    end

    private

    def disable_requiretty!
      if supports_requiretty?(@machine) && (not @set)
        @machine.guest.capability(:norequiretty)
        @set = true
      end
    end

    def supports_requiretty?(machine)
      machine.communicate.ready? && machine.guest.capability?(:norequiretty)
    rescue Vagrant::Errors::VagrantError
      # WinRM will raise an error if the VM isn't running instead of
      # returning false.
      false
    end

  end
end
