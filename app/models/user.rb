class User < ActiveRecord::Base

  validates :email_address, presence: true, uniqueness: true

  has_secure_password

end
