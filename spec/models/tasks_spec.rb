require 'rails_helper'

describe Task do

  before do
    project = Project.create(description: Faker::App.name)
    @task = Task.new(
                        project_id: project.id,
                        title: "title",
                        description: "description",
                        complete: false,
                        due_date: '01/01/1999')

    @task_update = Task.create(
                                project_id: project.id,
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


    describe '#update' do
      it "should be able to update completed task to any date" do

        @task_update.update(:due_date => '01/01/2999')
        @task_update.valid?
        expect(@task_update.errors[:due_date].present?).to be(false)

        @task_update.update(:due_date => '01/01/1999')
        @task_update.valid?
        expect(@task_update.errors[:due_date].present?).to be(false)
      end
    end




end
