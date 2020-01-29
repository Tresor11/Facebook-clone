# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    @post = Post.create(content: 'text123', creator_id: @user.id)
    @commenta = Comment.create(comment_content: 'testing', post_id: @post.id, commenter_id: @user.id)
    @commentb = Comment.create(comment_content: 'testing', post_id: @post.id)
  end

  context 'with valid details' do
    it 'should create a comment' do
      expect(@commenta).to be_valid
    end
  end

  context 'with invalid details' do
    it 'should not create a comment' do
      expect(@commentb).to_not be_valid
    end
  end
end
