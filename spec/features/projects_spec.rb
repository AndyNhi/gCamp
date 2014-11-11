require 'rails_helper'

feature "Projects Crud" do

  def create_project
    visit "/projects"
    click_on "Create Project"
    fill_in "Description", with: "example"
    click_on "Create Project"
    expect(page).to have_content "example"
  end


  scenario "create project" do
    create_project
  end


  scenario "read project" do
    create_project
    visit '/projects'
    click_on "example"
    expect(page).to have_content "example"
  end


  scenario "update project" do
    create_project
    visit "/projects"
    click_on "example"
    click_on "Edit"
    fill_in "Description", with: "Andy"
    click_on "Update Project"
    expect(page).to have_content :notice
  end


  scenario "destroy project" do
    create_project
    visit "/projects"
    click_on "example"
    click_on "Destroy"
    expect(page).to have_no_content "example"
  end


end

feature "Validation Projects" do

  scenario "validates name cannot be blank" do
    visit "/projects"
    click_on "Create Project"
    click_on "Create Project"
    expect(page).to have_content "Description can't be blank"
  end


end
