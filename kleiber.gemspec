# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kleiber/version'

Gem::Specification.new do |spec|
  spec.name          = 'kleiber'
  spec.version       = Kleiber::VERSION
  spec.authors       = ['kirill_bobykin']
  spec.email         = ['qelphybox@gmail.com']

  spec.summary       = 'Manage your development enviroments faster!'
  spec.description   = 'If you need to develop more than one application and they actively communicate each other.'
  spec.homepage      = 'https://github.com/qelphybox/kleiber'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'thor'
end
