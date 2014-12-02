require 'rails_helper'

feature "Projects Crud" do

  before(:each) do
    User.create!(first_name: 'Andy', last_name: 'Nguyen', email_address: 'example@email.com', password: 'pass', password_confirmation: 'pass')
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'pass'
    click_on 'Log In'
  end

  def create_project
    signin
    visit "/projects"
    click_on "Create Project"
    fill_in "Description", with: "example"
    click_on "Create Project"
    expect(page).to have_content "example"
  end

  scenario "project can be created" do
    create_project
  end

  scenario "project can be shown" do
    create_project
    visit '/projects'
    click_on "example"
    expect(page).to have_content "example"
  end

  scenario "project can be updated" do
    create_project
    visit "/projects"
    click_on "example"
    click_on "Edit"
    fill_in "Description", with: "Andy"
    click_on "Update Project"
    expect(page).to have_content :notice
  end

  scenario "project can be destroyed" do
    create_project
    visit "/projects"
    click_on "example"
    click_on "Delete"
    expect(page).to have_no_content "example"
  end

end

feature "Project Validation" do

  before(:each) do
    User.create!(first_name: 'Andy', last_name: 'Nguyen', email_address: 'example@email.com', password: 'pass', password_confirmation: 'pass')
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'pass'
    click_on 'Log In'
  end


  scenario "validates presence of name" do
    signin
    visit "/projects"
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content "Description can't be blank"
  end


end
