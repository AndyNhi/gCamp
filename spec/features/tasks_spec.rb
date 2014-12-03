require 'rails_helper'

feature "Task Crud" do

  before do
    @user = create_user
    @project = create_project
    @membership = create_membership(user_id: @user.id, project_id: @project.id)
    signin
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario "create task" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Description", with: "test1"
    fill_in "Due date", with: "01/01/2999"
    click_on "Create Task"
    expect(page).to have_content "test1"
    click_on "Task"
  end

  scenario "show task" do
    task = create_task(project_id: @project.id)
    visit project_tasks_path(@project, task)
    expect(page).to have_content task.description
  end

  scenario "update task" do
    task = create_task(project_id: @project.id)
    visit project_tasks_path(@project, task)
    click_on "Edit"
    fill_in "Description", with: "Andy"
    click_on "Update Task"
    expect(page).to have_content "Andy"
  end

  scenario "destroy task" do
    task = create_task(project_id: @project.id)
    visit project_tasks_path(@project, task)
    click_on "delete"
    expect(page).to have_no_content task.description
  end

  scenario "validates presence of error message if description blank" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "validates due date is set to present to future" do
    visit project_tasks_path(@project)
    click_on "Create Task"
    fill_in "Due date", with: "01/01/2011"
    click_on "Create Task"
    expect(page).to have_content "can't be in the past"
  end

end
