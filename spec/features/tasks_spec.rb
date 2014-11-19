require 'rails_helper'

feature "Task Crud" do

  before do
    project = Project.create(description: Faker::App.name)
  end


  def create_task
    visit "/projects"
    click_on "0"
    click_on "Create Task"
    fill_in "Description", with: "test1"
    fill_in "Due date", with: "25/01/2999"
    click_on "Create Task"
    expect(page).to have_content "test1"
    click_on "Back"
  end

  scenario "create tasks" do
    create_task
  end

  scenario "read tasks" do
    create_task
    click_on "Show"
    expect(page).to have_content "test1"
  end

  scenario "update tasks" do
    create_task
    click_on "Edit"
    fill_in "Description", with: "Andy"
    click_on "Update Task"
    expect(page).to have_content "Andy"
  end

  scenario "destroy tasks" do
    create_task
    click_on "Destroy"
    expect(page).to have_no_content "test1"
  end


end

feature "Task Validation" do

  before do
    project = Project.create(description: Faker::App.name)
  end

  scenario "validates blank description cannot be submitted" do
    visit "/projects"
    click_on "0"
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content "Description can't be blank"
  end


  scenario "validates due date cannot be in past" do

    visit "/projects"
    click_on "0"
    click_on "Create Task"
    fill_in "Due date", with: "01/01/2011"
    click_on "Create Task"
    expect(page).to have_content "can't be in the past"

  end


end
