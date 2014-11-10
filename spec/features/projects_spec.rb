require 'rails_helper'

feature "Projects Crud" do

  def create_project
    visit "/projects"
    click_link "Create Project"
    fill_in "Description", with: "example"
    click_button "Submit"
    expect(page).to have_content "example"
  end


  scenario "create project" do
    create_project
  end


  scenario "read project" do
    create_project
    visit '/projects'
    click_link "example"
    expect(page).to have_content "example"
  end


  scenario "update project" do
    create_project
    visit "/projects"
    click_link "example"
    click_link "Edit"
    fill_in "Description", with: "Andy"
    click_button "Submit"
    expect(page).to have_content :notice
  end


  scenario "destroy project" do
    create_project
    visit "/projects"
    click_link "example"
    click_link "Destroy"
    expect(page).to have_no_content "example"
  end


end

feature "Validation Projects" do

  scenario "validates name cannot be blank" do
    visit "/projects"
    click_link "Create Project"
    click_button "Submit"
    expect(page).to have_content "Description can't be blank"
  end


end
