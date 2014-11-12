require 'rails_helper'

describe Task do

  before do
    @task = Task.new(
                        title: "title",
                        description: "description",
                        complete: false,
                        due_date: '01/01/1999')
  end

    describe '#create' do
      it "should have a validation only setting completion dates on or ahead of present date" do
        @task.valid?
        expect(@task.errors[:due_date].present?).to be(true)

        @task.due_date = '01/01/2999'
        @task.valid?
        expect(@task.errors[:due_date].present?).to be(false)
    end
  end


end
