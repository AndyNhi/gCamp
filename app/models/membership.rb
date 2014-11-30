class Membership < ActiveRecord::Base

  belongs_to :project
  belongs_to :user

  validates :user, uniqueness: {scope: :project, message: "has already been added"}
  validates_presence_of :user
  validates :role, presence: true 

end
