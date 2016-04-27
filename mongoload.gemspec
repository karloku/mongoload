# -*- encoding: utf-8 -*-
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoload/version'

Gem::Specification.new do |gem|
  gem.name          = 'mongoload'
  gem.version       = Mongoload::VERSION
  gem.summary       = 'Perform eager loading automatically for Mongoid'
  gem.description   = 'Automatic Mongoid eager loading'
  gem.license       = 'MIT'
  gem.authors       = ['Kaloku Sang']
  gem.email         = 'karloku@gmail.com'
  gem.homepage      = 'https://github.com/karloku/mongoload'

  gem.required_ruby_version = '>= 2.1.0'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files    = Dir.glob('spec/**/*')
  gem.require_paths = ['lib']

  gem.add_dependency 'mongoid', ['>= 5.0.0']

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 11.0'
  gem.add_development_dependency 'rdoc', '~> 4.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'database_cleaner', '~> 1.5.3'
  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
