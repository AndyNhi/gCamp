require 'rails_helper'

describe 'Comment' do

  before(:each) do
    project = FactoryGirl.create(:project)
    @user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, due_date: '01/01/2999', project_id: project.id)
    @comment = FactoryGirl.build(:comment, user_id: @user.id, task_id: task.id)
  end

  it 'is valid with a user' do
    expect(@comment).to be_valid
  end

  it 'should have an associated user' do
    expect(@comment.user_id).to eq(@user.id)
  end

end
