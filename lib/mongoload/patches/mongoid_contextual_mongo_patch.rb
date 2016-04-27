# frozen_string_literal: true
module Mongoload
  module MongoContextWithAutoInclude
    def documents_for_iteration
      results = super
      if results.is_a?(Mongo::Collection::View)
        results = results.map { |doc| Mongoid::Factory.from_db(klass, doc, criteria.options[:fields]) }
      end
      results.tap do |documents|
        Mongoload::AutoIncludeContext.register_docs(documents.to_a)
      end
    end
  end
end

Mongoid::Contextual::Mongo.prepend Mongoload::MongoContextWithAutoInclude
