  require 'rails_helper'

feature "Project" do

  before(:each) do
    @user = create_user
    @project = create_project
    signin
  end

  def signin
    visit root_path
    click_on 'Sign In'
    visit '/sign-in'
    fill_in 'Email', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario "create project" do
    visit projects_path
    click_on 'Create Project'
    fill_in 'Description', with: 'Project K'
    click_on 'Create Project'
    expect(page).to have_content('Project K')
  end

  scenario "show project" do
    create_membership(user_id: @user.id, project_id: @project.id)
    visit project_path(@project)
    expect(page).to have_content @project.description
  end

  scenario "update project" do
    create_membership(user_id: @user.id, project_id: @project.id, role: 'Owner')
    visit project_path(@project)
    click_on "Edit"
    fill_in "Description", with: "Project X"
    click_on "Update Project"
    expect(page).to have_content :notice
  end

  scenario "destroy project" do
    create_membership(user_id: @user.id, project_id: @project.id)
    visit project_path(@project)
    click_on "Delete"
    expect(page).to have_no_content @project.description
  end

  scenario "validates presence of description with error message" do
    visit projects_path
    click_on 'Create Project'
    click_on 'Create Project'
    expect(page).to have_content "Description can't be blank"
  end

end
