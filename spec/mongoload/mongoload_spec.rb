# frozen_string_literal: true
require 'spec_helper'

describe Mongoload do
  let(:user1) do
    User.create!(username: 'Adam') { |u| u.create_device(uuid: '111') }
  end
  let(:user2) do
    User.create!(username: 'Betty') { |u| u.create_device(uuid: '222') }
  end
  let(:user3) do
    User.create!(username: 'Cathy') { |u| u.create_device(uuid: '333') }
  end

  let(:tag1) { Tag.create!(name: 'tag1') }
  let(:tag2) { Tag.create!(name: 'tag2') }
  let(:tag3) { Tag.create!(name: 'tag3') }
  let(:tag4) { Tag.create!(name: 'tag4') }

  let(:post1) do
    Post.create!(title: 'post1') do |p|
      p.user = user1
      p.tags << [tag1, tag2]
    end
  end

  let(:post2) do
    Post.create!(title: 'post2') do |p|
      p.user = user1
    end.tags << [tag2, tag3]
  end

  let(:post3) do
    Post.create!(title: 'post3') do |p|
      p.user = user2
    end.tags << [tag1, tag3]
  end

  let(:post4) do
    Post.create!(title: 'post4') do |p|
      p.user = user2
    end.tags << [tag2, tag4]
  end

  let(:post5) do
    Post.create!(title: 'post5') do |p|
      p.user = user3
    end.tags << [tag1, tag4]
  end

  let(:post6) do
    Post.create!(title: 'post6') do |p|
      p.user = user3
    end.tags << [tag2, tag4]
  end

  describe 'has_one relation' do
    before { user1 && user2 && user3 }

    it 'should eager load' do
      users = User.all.to_a
      users.each do |user|
        expect(user.ivar(:device)).to be false
      end

      users.first.device
      users.each do |user|
        expect(user.ivar(:device)).to be_truthy
      end
    end
  end

  describe 'has_many relation' do
    before { post1 && post2 && post3 && post4 && post5 && post6 }

    it 'should eager load' do
      users = User.all.to_a
      users.each do |user|
        expect(user.posts._loaded?).to be false
      end

      users.first.posts.to_a
      users.each do |user|
        expect(user.posts._loaded?).to be true
      end
    end
  end

  describe 'belongs_to' do
    context 'inverse of has_one' do
      before { user1 && user2 && user3 }

      it 'should eager load' do
        devices = Device.all.to_a
        devices.each do |device|
          expect(device.ivar(:user)).to be false
        end

        devices.first.user
        devices.each do |device|
          expect(device.ivar(:user)).to be_truthy
        end
      end
    end

    context 'inverse of has_many' do
      before { post1 && post2 && post3 && post4 && post5 && post6 }

      it 'should eager load' do
        posts = Post.all.to_a
        posts.each do |post|
          expect(post.ivar(:user)).to be false
        end

        posts.first.user
        posts.each do |post|
          expect(post.ivar(:user)).to be_truthy
        end
      end
    end
  end

  describe 'has_and_belongs_to_many' do
    before { post1 && post2 && post3 && post4 && post5 && post6 }

    it 'should eager load' do
      posts = Post.all.to_a
      posts.each do |post|
        expect(post.tags._loaded?).to be false
      end

      posts.first.tags.to_a
      posts.each do |post|
        expect(post.tags._loaded?).to be true
      end
    end
  end
end
