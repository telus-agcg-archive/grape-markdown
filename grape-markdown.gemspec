# coding: utf-8

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape-markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'grape-markdown'
  spec.version       = GrapeMarkdown::VERSION
  spec.authors       = ['John Allen']
  spec.email         = ['john@threedogconsulting.com']
  spec.homepage      = 'https://github.com/connexio-labs/grape-markdown'
  spec.license       = 'MIT'

  spec.summary = <<-SUMMARY
    Allows for generating a Markdown document from you Grape API
  SUMMARY

  spec.description = <<-DESCRIPTION
    Auto generates Markdown from the docuementation that is created by your Grape API}
  DESCRIPTION

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'grape', '>= 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'guard', '~> 2.4'
  spec.add_development_dependency 'guard-bundler', '~> 2.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.2'
  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'rubocop', '~> 0.60.0'
end
