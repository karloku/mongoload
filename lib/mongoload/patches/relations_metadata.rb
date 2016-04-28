# frozen_string_literal: true
module Mongoload
  module RelationsMetadataWithOptions
    def auto_include?
      fetch(:auto_include, true)
    end

    def fully_load?
      fetch(:fully_load, false)
    end
  end
end

::Mongoid::Relations::Metadata.include ::Mongoload::RelationsMetadataWithOptions
