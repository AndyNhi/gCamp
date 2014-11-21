class User < ActiveRecord::Base

  has_many :memberships
  has_many :projects, through: :memberships
  has_many :comments

  validates :email_address, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  has_secure_password


end
