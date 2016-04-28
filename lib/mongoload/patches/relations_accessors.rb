# frozen_string_literal: true
module Mongoload
  module RelationsAccessorsWithAutoInclude
    private

    def get_relation(name, metadata, object, reload=false)
      # has_one and belongs_to will return the value immediately
      # while other relation are lazy
      if [Mongoid::Relations::Referenced::In, Mongoid::Relations::Referenced::One].include?(metadata.relation)
        Mongoload::RelationLoader.load(self, metadata) if !object.is_a?(metadata.klass) && ivar(name) == false
      end

      result = super
      result.tap do |relation|
        if relation.class == Mongoid::Relations::Targets::Enumerable
          relation.target.define_singleton_method :relation_metadata do
            relation.relation_metadata
          end

          relation.target.define_singleton_method :base do
            relation.base
          end
        end
      end
    end
  end
end

Mongoid::Document.prepend Mongoload::RelationsAccessorsWithAutoInclude
