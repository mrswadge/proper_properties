# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'escape_java_properties/version'

Gem::Specification.new do |spec|
  spec.name          = "escape_java_properties"
  spec.version       = EscapeJavaProperties::VERSION
  spec.authors       = ["trace-devops"]
  spec.email         = ["isysdevops@tracegroup.com"]
  spec.summary       = %q{Loader and writer for Java properties files}
  spec.description   = %q{Library for loading and writing of Java properties files that matches java.util.Properties behaviour}
  spec.homepage      = "https://github.com/trace-devops/escape_java_properties"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  # development dependencies  
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'minitest'
end
