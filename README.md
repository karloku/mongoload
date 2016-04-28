# Mongoload
[![Gem Version](https://badge.fury.io/rb/mongoload.svg)](https://badge.fury.io/rb/mongoload)
[![Build Status](https://travis-ci.org/karloku/mongoload.svg?branch=master)](https://travis-ci.org/karloku/mongoload)

Mongoload is a gem to perform eager loading automatically for Mongoid, inspired by [Goldiloader](https://github.com/salsify/goldiloader).

## Usage

Just install Mongoload. It will automatically eager load your reference relation the first time you access it.

## Install

Add this line to your application's Gemfile:

    gem 'mongoload'

Or install it yourself as:

    $ gem install mongoload

## Options

### :auto_include

Mark if Mongoload should perform eager loading on the relation.
Pass ```:auto_include``` option to the definition, the value should be ```true```(by default) or ```false```.

```ruby
class User
  include Mongoid::Document
  has_one :device, auto_include: false # Do not perform automatic eager loading on :device relation
  has_many :posts

  field :username
end

# Following call will not trigger automatic eager loading on device
User.all.each(&:device)
```

### :fully_load

Mark if Mongoload should perform eager loading on the relation, when accessed by following methods:

  + #first
  + #last
  + #size
  + #empty?

Pass ```:fully_load``` option to the definition, the value should be ```true``` or ```false```(by default).

```ruby
class Tag
  include Mongoid::Document
  has_and_belongs_to_many :posts, fully_load: true

  field :name
end

# Following calls will trigger automatic eager loading on posts
Tag.all.each { |tag| tag.posts.first }
Tag.all.each { |tag| tag.posts.last }
Tag.all.each { |tag| tag.posts.size }
Tag.all.each { |tag| tag.posts.empty? }
```

PS: As for ```#second```, ```#third```, ```#fourth```, ```#fifth``` and ```#forty_two``` calls, mongoid will delegate them to the entries of a relation enumerable set, which makes them just same as a ```#to_a``` call.

## Copyright

Copyright (c) 2016 Kaloku Sang

See LICENSE.txt for details.
