# frozen_string_literal: true

RSpec.describe User, type: :model do
  before :each do
    @user_a = User.create(email: 'foobar@example.com', first_name: 'foobar', password: 'foobar')
    @user_b = User.create(email: 'foobar@example.com', last_name: 'foobar', user_name: 'foobar', gender: 'male', first_name: 'foobar', password: 'foobar', password_confirmation: 'foobar')
  end

  context 'with invalid details' do
    it 'should not create a user' do
      expect(@user_a).to_not be_valid
    end
  end
  context 'with valid details' do
    it 'should create a user' do
      expect(@user_b).to be_valid
    end
  end
end
