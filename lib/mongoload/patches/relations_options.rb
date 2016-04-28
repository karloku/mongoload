# frozen_string_literal: true
module Mongoload
  module RelationsOptions
    MONGOLOAD_OPTIONS = [
      :auto_include,
      :fully_load
    ].freeze

    def validate!(options)
      options_clone = options.clone
      MONGOLOAD_OPTIONS.each { |key| options_clone.delete(key) }
      super(options_clone)
    end
  end
end

class << ::Mongoid::Relations::Options
  prepend ::Mongoload::RelationsOptions
end
