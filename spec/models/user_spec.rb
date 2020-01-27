# frozen_string_literal: true

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(email: 'foobar@example.com', first_name: 'foobar', password: 'foobar')
  end

  context 'with iinvalid details' do
    it 'should not create a user' do
      expect(@user).to_not be_valid
    end
  end
end
