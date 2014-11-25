require 'rails_helper'

describe Task do

  describe '#create' do
    it "should validate period of completion at present or future date" do
      task = FactoryGirl.build(:task)
      task.valid?
      expect(task.errors[:due_date].present?).to be(true)
      task.due_date = '01/01/2999'
      task.valid?
      expect(task.errors[:due_date].present?).to be(false)
    end
  end

  describe '#update' do
    it "should update without period validations" do
      task_update = FactoryGirl.build(:task, description: "update")
      task_update.update(:due_date => '01/01/2999')
      task_update.valid?
      expect(task_update.errors[:due_date].present?).to be(false)
      task_update.update(:due_date => '01/01/1999')
      task_update.valid?
      expect(task_update.errors[:due_date].present?).to be(false)
    end
  end

end
