# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  before :each do
    @user_a = User.create(email: 'foobar@example.com', first_name: 'aubin', last_name: 'aubin', user_name: 'aubin', gender: 'male', password: '123456', password_confirmation: '123456')
    @user_b = User.create(email: 'aubin@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    @request_a = Request.create(sender_id: @user_a.id, recever_id: @user_b.id)
    @request_b = Request.create(sender_id: @user_a.id, recever_id: @user_b.id)
    @request_c = Request.create(sender_id: @user_a.id)
  end
  context 'it should' do
    it 'allow a valid user to create a friend request' do
      expect(@request_a).to be_valid
    end

    it 'not allow to create a friend request twice' do
      expect(@request_b).to_not be_valid
    end

    it 'not allow to create an invalid friend request twice' do
      expect(@request_c).to_not be_valid
    end

    it 'send a fiend request to the recever' do
      expect(@user_b.receved_requests).to be_truthy
    end

    it 'create a pending fiend request to the sender' do
      expect(@user_a.sent_requests).to be_truthy
    end
  end
end
