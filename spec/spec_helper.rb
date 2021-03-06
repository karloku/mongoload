# frozen_string_literal: true
require 'rspec'
require 'database_cleaner'
require 'mongoload'

# initialize model definitions
ENV['MONGOID_ENV'] = 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), 'db', 'mongoid.yml'))
require_relative 'db/models'
Mongo::Logger.logger = Logger.new('log/test.log')

RSpec.configure do |config|
  config.order = 'random'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
