class User < ActiveRecord::Base

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  validates :email_address, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  has_secure_password


end
