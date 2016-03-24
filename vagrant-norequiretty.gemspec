# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-norequiretty/version'

Gem::Specification.new do |spec|
  spec.name          = 'vagrant-norequiretty'
  spec.version       = VagrantNoRequireTTY::VERSION
  spec.authors       = ['Charlie Sharpsteen']
  spec.email         = ['source@sharpsteen.net']
  spec.license       = 'Apache 2.0'

  spec.summary       = 'A Vagrant Plugin that ensures requiretty is disabled'
  spec.homepage      = 'https://github.com/oscar-stack/vagrant-norequiretty'
  spec.description   = <<-EOS
Ever get a "sorry, you must have a tty to run sudo" error? Maybe
this plugin can help!
  EOS

  spec.files         = %x[git ls-files].split($/)
  spec.require_paths = ['lib']
end
