# frozen_string_literal: true
module Mongoload
  module RelationsEnumerableWithAutoInclude
    # methods which trigger Mongoload only when :fully_load is true
    # other methods delegated to #target will be processed by #unloaded_documents
    %w(first last size empty?).each do |method|
      define_method method do
        if !_loaded? && relation_metadata.fully_load? && Mongoload::RelationLoader.load(base, relation_metadata)
          base.ivar(relation_metadata.name).public_send(method)
        else
          super()
        end
      end
    end

    private

    # perform eager loading when loading unloaded documents
    def unloaded_documents
      if !_loaded? && Mongoload::RelationLoader.load(base, relation_metadata)
        base.ivar(relation_metadata.name)
      else
        super
      end
    end
  end
end

Mongoid::Relations::Targets::Enumerable.prepend Mongoload::RelationsEnumerableWithAutoInclude
