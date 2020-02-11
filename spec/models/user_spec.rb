require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before(:each) do 
      @user = User.new
      user = @user
      user.password = 'Secure'
      user.password_confirmation = 'Secure'
      user.email = 'abc@123.com'

      
    end
    describe "email uniqueness" do
      subject { @user }
    it { should validate_uniqueness_of(:email).case_insensitive }
  
    end
    describe 'validations' do
      it 'is valid when fields all filled correctly' do
        expect(@user).to be_valid
      end
      it 'is not valid when user email is missing' do
        @user.email = nil
        expect(@user).to_not be_valid
      end
      it 'is not valid when password is missing' do 
        @user.password = nil
        expect(@user).to_not be_valid
      end
      it 'is not valid when password_confirmation is missing' do 
        @user.password_confirmation = nil
        expect(@user).to_not be_valid
      end
      it 'is not valid if password does not matches confirmation' do
        @user.password_confirmation = 'Insecure'
        expect(@user).to_not be_valid
      end
      it 'is not valid if password is too short' do
        @user.password_confirmation = '123'
        @user.password = '123'
        expect(@user).to_not be_valid
      end
    end
  end
  describe '.authenticate_with_credentials' do
    before(:each) do 
      @user = User.new
      user = @user
      user.password = 'Secure'
      user.password_confirmation = 'Secure'
      user.email = 'abc@123.com'
      @user.save
    end
    it 'returns user object when email and password are correct' do
    output = User.authenticate_with_credentials('abc@123.com', 'Secure')
    expect(output.email).to eq(@user.email)  
    end
    it 'can authenticate user even if there are trailing/leading spaces and wrong upper/lower cases for email as long as psw is right' do
      output = User.authenticate_with_credentials('ABC@123.com', 'Secure')
      expect(output.email.downcase).to eq(@user.email)  
    end
  end
end
