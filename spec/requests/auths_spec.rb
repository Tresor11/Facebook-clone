require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  describe 'GET /auths' do
    it 'should redirect to post index after sign in' do
      user = User.create(first_name: 'sharmarke', last_name: 'ahmed', user_name: 'mrnadaara', gender: 'male', email: 'ahmed@gmail.com', password: 'hey1234', password_confirmation: 'hey1234')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).to have_current_path(posts_path)
    end

    it 'should redirect to post index after sign up' do
      visit new_user_registration_path
      fill_in 'user_first_name', with: 'sharmarke'
      fill_in 'user_last_name', with: 'ahmed'
      fill_in 'user_user_name', with: 'mrnadaara'
      choose 'Male'
      fill_in 'user_email', with: 'ahmed@gmail.com'
      fill_in 'user_password', with: 'hey1234'
      fill_in 'user_password_confirmation', with: 'hey1234'
      click_button 'Sign up'
      expect(page).to have_current_path(posts_path)
    end

    it 'should re-render sign up when incorrect details entered, display validation errors' do
      visit new_user_registration_path
      fill_in 'user_first_name', with: 'sad'
      fill_in 'user_last_name', with: 'asd'
      fill_in 'user_user_name', with: 'a'
      fill_in 'user_email', with: 'aa@gmail.com'
      fill_in 'user_password', with: 'hey14'
      fill_in 'user_password_confirmation', with: 'hey1234'
      click_button 'Sign up'
      expect(page).to have_content('4 errors prohibited')
      expect(page).to have_current_path(user_registration_path)
    end
  end
end
