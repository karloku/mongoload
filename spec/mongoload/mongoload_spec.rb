# frozen_string_literal: true
require 'spec_helper'

describe Mongoload do
  let(:user1) do
    User.create!(username: 'Adam').tap { |u| u.create_device(uuid: '111') }
  end
  let(:user2) do
    User.create!(username: 'Betty').tap { |u| u.create_device(uuid: '222') }
  end
  let(:user3) do
    User.create!(username: 'Cathy').tap { |u| u.create_device(uuid: '333') }
  end
  let(:build_users) { [user1, user2, user3] }
  let(:users) { User.all.to_a }
  let(:devices) { Device.all.to_a }

  let(:tag1) { Tag.create!(name: 'tag1') }
  let(:tag2) { Tag.create!(name: 'tag2') }
  let(:tag3) { Tag.create!(name: 'tag3') }
  let(:tag4) { Tag.create!(name: 'tag4') }
  let(:tags) { Tag.all.to_a }

  let(:post1) do
    Post.create!(title: 'post1', user: user1).tap do |p|
      p.tags << [tag1, tag2]
    end
  end
  let(:post2) do
    Post.create!(title: 'post2', user: user1).tap do |p|
      p.tags << [tag2, tag3]
    end
  end
  let(:post3) do
    Post.create!(title: 'post3', user: user2).tap do |p|
      p.tags << [tag1, tag3]
    end
  end
  let(:post4) do
    Post.create!(title: 'post4', user: user2).tap do |p|
      p.tags << [tag2, tag4]
    end
  end
  let(:post5) do
    Post.create!(title: 'post5', user: user3).tap do |p|
      p.tags << [tag1, tag4]
    end
  end
  let(:post6) do
    Post.create!(title: 'post6', user: user3).tap do |p|
      p.tags << [tag2, tag4]
    end
  end
  let(:build_posts) { [post1, post2, post3, post4, post5, post6] }
  let(:posts) { Post.all.to_a }

  describe 'has_one relation' do
    before { build_users }

    it 'should eager load' do
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
    before { build_posts }

    it 'should eager load' do
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
      before { build_users }

      it 'should eager load' do
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
      before { build_posts }

      it 'should eager load' do
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
    before { build_posts }

    it 'should eager load' do
      posts.each do |post|
        expect(post.tags._loaded?).to be false
      end

      posts.first.tags.to_a
      posts.each do |post|
        expect(post.tags._loaded?).to be true
      end
    end
  end

  describe 'auto_include' do
    before { build_users }
    context 'is set to false' do
      before do
        UserWithoutAutoInclude = User.clone
        UserWithoutAutoInclude.has_one :device, auto_include: false
      end
      it 'should not eager load' do
        users = UserWithoutAutoInclude.all.to_a
        users.each do |user|
          expect(user.ivar(:device)).to be false
        end

        users.first.device
        users[1..-1].each do |user|
          expect(user.ivar(:device)).to be false
        end
      end
    end
  end

  describe 'fully_load' do
    FULLY_LOAD_METHODS = %w(first last size empty?).freeze
    before { build_posts }

    context 'is set to true' do
      FULLY_LOAD_METHODS.each do |method|
        it "should eager load with ##{method}" do
          tags.each do |tag|
            expect(tag.posts._loaded?).to be false
          end

          tags.first.posts.public_send(method)
          tags.each do |tag|
            expect(tag.posts._loaded?).to be true
          end
        end
      end
    end

    context 'is set to false' do
      FULLY_LOAD_METHODS.each do |method|
        it "should not eager load with ##{method}" do
          posts.each do |post|
            expect(post.tags._loaded?).to be false
          end

          posts.first.tags.public_send(method)
          posts[1..-1].each do |post|
            expect(post.tags._loaded?).to be false
          end
        end
      end
    end
  end
end
