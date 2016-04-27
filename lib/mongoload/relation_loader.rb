# frozen_string_literal: true
module Mongoload
  module RelationLoader
    module_function

    def load(doc, metadata)
      docs = doc.auto_include_context.docs.select do |d|
        auto_include?(d, metadata)
      end
      eager_load(metadata, docs)
      docs.include?(doc)
    end

    def eager_load(metadata, docs)
      metadata.relation.eager_load_klass.new([metadata], docs).run
    end

    def auto_include?(doc, metadata)
      relation?(doc, metadata) && !loaded?(doc, metadata)
    end

    def relation?(doc, metadata)
      doc.relations.values.include?(metadata)
    end

    def loaded?(doc, metadata)
      if [Mongoid::Relations::Referenced::In, Mongoid::Relations::Referenced::One].include?(metadata.relation)
        doc.ivar(metadata.name) != false
      else
        doc.public_send(metadata.name)._loaded?
      end
    end
  end
end
