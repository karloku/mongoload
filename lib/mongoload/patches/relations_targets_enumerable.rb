# frozen_string_literal: true
module Mongoload
  module RelationsEnumerableWithAutoInclude
    private

    def unloaded_documents
      if Mongoload::RelationLoader.load(base, relation_metadata)
        base.ivar(relation_metadata.name)
      else
        super
      end
    rescue NotImplementedError
      super
    end
  end
end

Mongoid::Relations::Targets::Enumerable.prepend Mongoload::RelationsEnumerableWithAutoInclude
