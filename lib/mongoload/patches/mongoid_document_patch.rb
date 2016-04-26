# frozen_string_literal: true
module Mongoload
  module AutoIncludableModel
    extend ActiveSupport::Concern

    included do
      attr_writer :auto_include_context
    end

    def initialize_copy(other)
      super
      @auto_include_context = nil
    end

    def auto_include_context
      @auto_include_context ||= Mongoload::AutoIncludeContext.new.register_docs(self)
    end

    def reload(*)
      @auto_include_context = nil
      super
    end
  end
end

Mongoid::Document.include Mongoload::AutoIncludableModel
