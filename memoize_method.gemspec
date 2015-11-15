# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memoize_method/version'

Gem::Specification.new do |spec|
  spec.name          = "memoize_method"
  spec.version       = MemoizeMethod::VERSION
  spec.authors       = ["Adam Hess"]
  spec.email         = ["adamhess1991@gmail.com"]

  spec.summary       = %q{allow simple caching of ruby methods.}
  spec.description   = %q{will expose your method, which is cached, a cacheless version and a recompute version}
  spec.homepage      = "https://github.com/HParker/ruby_memoize_method"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
