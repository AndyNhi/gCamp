require 'rails_helper'

describe User do

  describe "#create" do
    it "should validate uniqueness of email address" do
      user = create_user
      expect(user).to be_valid
      user_1 = create_user(email_address: user.email_address)
      user_1.valid?
      expect(user_1.errors[:email_address]).to include("has already been taken")
    end
  end

end
