require 'rails_helper'

feature "User Crud" do

  def create_user
    visit "/users"
    click_link "Create User"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "test"
    fill_in "Email address", with: "test@email.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_button "Create User"
    expect(page).to have_content :notice
  end


  scenario "create user" do
    create_user
  end


  scenario "read user" do
    create_user
    visit '/users'
    click_link "test test"
    expect(page).to have_content "test@email.com"
  end


  scenario "update user" do
    create_user
    visit "/users"
    click_link "Edit"
    fill_in "First name", with: "Andy"
    click_button "Update User"
    expect(page).to have_content "Andy"
  end


  scenario "destroy user" do
    create_user
    visit "/users"
    click_link "Edit"
    click_link "Delete User"
    expect(page).to have_no_content "test test"
  end


end
