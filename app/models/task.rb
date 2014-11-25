class Task < ActiveRecord::Base

  belongs_to :project
  has_many :comments, dependent: :destroy

  def due_soon?
    if self.due_date
      true if self.due_date <= (Date.today + 7)
    else
      nil
    end
  end

  paginates_per 10

  validates :description, presence: true

  def on_or_after
    if due_date.present? && due_date <= Date.current
      errors.add(:due_date, "can't be in the past")
    end
  end

  validate :on_or_after, on: :create

end
