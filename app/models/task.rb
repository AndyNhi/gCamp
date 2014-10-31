class Task < ActiveRecord::Base

  def due_soon?
    if self.due_date
      true if self.due_date <= (Date.today + 7)
    else
      nil
    end
  end

  paginates_per 10

end
