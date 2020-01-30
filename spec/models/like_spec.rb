# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    @post = Post.create(content: 'text123', creator_id: @user.id)
    @lika = Like.create(post_id: @post.id, user_id: @user.id)
    @likb = Like.create(post_id: @post.id)
  end

  context 'with valid details' do
    it 'should like a post' do
      expect(@lika).to be_valid
    end
  end

  context 'with invalid details' do
    it 'should not create not like a post' do
      expect(@likb).to_not be_valid
    end
  end
end
