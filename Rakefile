# encoding: utf-8
# frozen_string_literal: true

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'

require 'rubygems/tasks'
Gem::Tasks.new

require 'rdoc/task'
RDoc::Task.new
task doc: :rdoc

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

task test: :spec
task default: :spec
