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
end
