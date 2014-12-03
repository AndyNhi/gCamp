require 'rails_helper'

describe Task do

  describe '#create' do
    it "should validate period of completion at present or future date" do
      task = new_task(due_date: '01/01/1999')
      expect(task).to be_invalid
      task.due_date = '01/01/2999'
      task.valid?
      expect(task.errors[:due_date].present?).to be(false)
    end
  end

  describe '#update' do
    it "should update without period validations" do
    end
  end

end
