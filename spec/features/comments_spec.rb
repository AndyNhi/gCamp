require 'rails_helper'
feature 'Comments' do

  before(:each) do
    @user = create_user
    @project = create_project
    @membership = create_membership(project_id: @project.id, user_id: @user.id)
    @task = create_task(project_id: @project.id)
  end

  def sign_in
    visit root_path
    click_on 'Sign In'
    fill_in 'Email address', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario 'can be added to task by a valid user' do
    sign_in
    visit project_task_path(@project, @task)
    fill_in('comment_copy', :with=> 'BLAH')
    click_on 'Add Comment'
    expect(page).to have_content("BLAH")
  end

end
