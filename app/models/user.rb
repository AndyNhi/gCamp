class User < ActiveRecord::Base

  validates :first_name, :last_name, :email_address, presence: true, uniqueness: true

  has_secure_password


end
