require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'redirect to post index page when new post created' do
      user = User.create(first_name: 'sharmarke', last_name: 'ahmed', user_name: 'mrnadaara', gender: 'male', email: 'ahmed@gmail.com', password: 'hey1234', password_confirmation: 'hey1234')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      fill_in 'post_content', with: 'YOOOOOOOOOO'
      click_button 'create post'
      expect(page).to have_current_path(posts_path)
    end

    it 'should display flash message when post creation succeeds or fails' do
      user = User.create(first_name: 'sharmarke', last_name: 'ahmed', user_name: 'mrnadaara', gender: 'male', email: 'ahmed@gmail.com', password: 'hey1234', password_confirmation: 'hey1234')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      fill_in 'post_content', with: 'YOOOOOOOOOO'
      click_button 'create post'
      expect(page).to have_content('Successfully posted!')
      fill_in 'post_content', with: 'YO'
      click_button 'create post'
      expect(page).to have_content('Failed to post')
    end
  end
end
