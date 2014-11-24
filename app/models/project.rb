class Project < ActiveRecord::Base

  paginates_per 10

  validates :description, presence: true

  has_many :tasks
  has_many :memberships
  # def memberships
  #   Membership.where(project_id: self.id)
  # end
  has_many :users, through: :memberships

end
