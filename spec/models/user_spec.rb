require 'rails_helper'
RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) {build :user }
    it 'should be valid user with all attribute' do
      expect(user.valid?).to eq(true)
    end
  end

  context 'validations' do
    it 'is not valid without a name' do
      user = build(:user, name: nil,role_id:1)
      debugger
      expect(user).to_not be_valid
    end

    it 'is not valid without a phone number' do
      user = build(:user, phone_no: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid if the phone number is not 10 characters long' do
      user = build(:user, phone_no: '123456789') # Less than 10 characters
      expect(user).to_not be_valid
    end

    it 'is not valid if the phone number is not all digits' do
      user = build(:user, phone_no: '1234abc567') # Contains non-digit characters
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password_digest: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a short password' do
      user = build(:user, password_digest: 'short')
      expect(user).to_not be_valid
    end
  end
end
