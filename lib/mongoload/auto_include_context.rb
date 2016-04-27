# frozen_string_literal: true
module Mongoload
  class AutoIncludeContext
    attr_reader :docs

    def initialize
      @docs = []
    end

    def register_docs(docs)
      Array.wrap(docs).each do |model|
        model.auto_include_context = self
        self.docs << model
      end
      self
    end

    def self.register_docs(docs)
      auto_include_context = new
      auto_include_context.register_docs(docs)
    end
  end
end
