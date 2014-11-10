require 'rails_helper'

feature "Task Crud" do

  def create_task
    visit "/tasks"
    click_link "Create Task"
    fill_in "Description", with: "test1"
    fill_in "Due date", with: "25/01/2014"
    click_button "Create Task"
    expect(page).to have_content "test1"
    visit "/tasks"
  end

  scenario "create tasks" do
    create_task
  end

  scenario "read tasks" do
    create_task
    visit "/tasks"
    click_link "Show"
    expect(page).to have_content "test1"
  end

  scenario "update tasks" do
    create_task
    visit "/tasks"
    click_link "Edit"
    fill_in "Description", with: "Andy"
    click_button "Update Task"
    expect(page).to have_content "Andy"
  end

  scenario "destroy tasks" do
    create_task
    visit "/tasks"
    click_link "Destroy"
    expect(page).to have_no_content "test1"
  end


end

feature "Task Validation" do

  scenario "validates blank description cannot be submitted" do

    visit "/tasks"
    click_link "Create Task"
    click_button "Create Task"
    expect(page).to have_content "Description can't be blank"

  end


end
