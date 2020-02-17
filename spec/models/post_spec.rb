# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    @posta = Post.create(content: 'text123', creator_id: @user.id)
    @postb = Post.create(content: 'text123')
  end

  context 'with valid details' do
    it 'should create a post' do
      expect(@posta).to be_valid
    end
  end

  context 'with invalid details' do
    it 'should no create a post' do
      expect(@postb).to_not be_valid
    end
  end
end
