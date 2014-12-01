class Comment < ActiveRecord::Base

  validates :copy, presence: true
  belongs_to :task
  belongs_to :user

end
