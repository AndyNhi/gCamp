class User < ActiveRecord::Base

  validates :email_address, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  has_secure_password


end
