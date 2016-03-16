# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'convey_user/version'

Gem::Specification.new do |spec|
  spec.name          = "convey_user"
  spec.version       = ConveyUser::VERSION
  spec.authors       = ["Jonathan Gertig"]
  spec.email         = ["jcgertig@gmail.com"]

  spec.summary       = %q{User controll for convey apps}
  spec.description   = %q{User controll for convey apps}
  spec.homepage      = "https://github.com/jcgertig/ConveyUser"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://gihub.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.3.1"
  spec.add_dependency "jwt", "~> 1.5.1"
  spec.add_dependency "orm_adapter", "~> 0.1"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
