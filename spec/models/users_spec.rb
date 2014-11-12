require 'rails_helper'


describe User do

  before do
    user = User.create(first_name: "example", last_name: "example", email_address: "example@email.com", password: "password", password_confirmation: "password")
  end

  describe "#create" do
    it "validates users email address is unique" do
      user_1 = User.new(email_address: "example@email.com")
      user_1.valid?
      expect(user_1.errors[:email_address].present?).to be(true)

      user_1.email_address = "yo@email.com"
      user_1.valid?
      expect(user_1.errors[:email_address].present?).to be(false)
    end
  end

end
