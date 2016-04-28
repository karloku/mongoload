# frozen_string_literal: true
class User
  include Mongoid::Document
  has_one :device
  has_many :posts

  field :username
end

class Device
  include Mongoid::Document
  belongs_to :user

  field :uuid
end

class Post
  include Mongoid::Document
  belongs_to :user
  has_and_belongs_to_many :tags, fully_load: true

  field :title
end

class Tag
  include Mongoid::Document
  has_and_belongs_to_many :posts

  field :name
end
