# frozen_string_literal: true
module Mongoload
  module MongoRelationsAccessorsWithAutoInclude
    private

    def get_relation(name, metadata, object, reload=false)
      # has_one and belongs_to will return the value immediately
      # while other relation are lazy
      if [Mongoid::Relations::Referenced::In, Mongoid::Relations::Referenced::One].include?(metadata.relation)
        Mongoload::RelationLoader.load(self, metadata) if !object.is_a?(metadata.klass) && ivar(name) == false
      end

      super
    end
  end
end

Mongoid::Document.prepend Mongoload::MongoRelationsAccessorsWithAutoInclude
