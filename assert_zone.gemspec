# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'assert_zone/version'

Gem::Specification.new do |spec|
  spec.name          = 'assert_zone'
  spec.version       = AssertZone::VERSION
  spec.authors       = ['David Radcliffe']
  spec.email         = ['radcliffe.david@gmail.com']

  spec.summary       = %q{Assert DNS zone files.}
  spec.description   = %q{Assert that a DNS server returns the correct responses based on a zone file.}
  spec.homepage      = 'https://github.com/dwradcliffe/assert_zone'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_dependency 'rspec', '~> 3.4.0'
  spec.add_dependency 'rspec-dns', '~> 0.1.6'
  spec.add_dependency 'dns-zone', '~> 0.2.0'
end
