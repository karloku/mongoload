# frozen_string_literal: true
module Mongoload
  module MongoRelationsEnumerableWithAutoInclude
    private

    def unloaded_documents
      metadata = relation_metadata
      Mongoload::RelationLoader.load(base, metadata)
    rescue Errors::EagerLoad
      super
    end
  end
end

Mongoid::Relations::Targets::Enumerable.prepend Mongoload::MongoRelationsEnumerableWithAutoInclude
