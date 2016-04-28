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

## TODO

* option to perform eager loading when calling following methods on an many/many_to_many relation:
  + size
  + first
  + last
+ option to disable eager loading on specific relation

## Copyright

Copyright (c) 2016 Kaloku Sang

See LICENSE.txt for details.
