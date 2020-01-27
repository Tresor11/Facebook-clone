# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    @post = Post.create(content: 'text123', creator_id: @user.id)
  end

  context 'with valid details' do
    it 'should create a post' do
      expect(@post).to be_valid
    end
  end
end
