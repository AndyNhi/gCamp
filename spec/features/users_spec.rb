require 'rails_helper'

feature "User Crud" do

  def create_user
    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "test"
    fill_in "Email address", with: "test@email.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content :notice
  end

  scenario "create user" do
    create_user
  end

  scenario "read user" do
    create_user
    visit '/users'
    click_on "test test"
    expect(page).to have_content "test@email.com"
  end

  scenario "update user" do
    create_user
    visit "/users"
    click_on "Edit"
    fill_in "First name", with: "Andy"
    click_on "Update User"
    expect(page).to have_content "Andy"
  end

  scenario "destroy user" do
    create_user
    visit "/users"
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content "test test"
  end


end

feature "User Validation" do

  scenario "validates user cannot have blank name and email" do
    visit "/users"
    click_on "Create User"
    click_on "Create User"
    expect(page).to have_content "prohibited"
  end

  scenario "validates the email is unique" do

    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "test"
    fill_in "Email address", with: "test@email.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content :notice

    visit "/users"
    click_on "Create User"
    fill_in "Email", with: 'test@email.com'
    click_on "Create User"

    expect(page).to have_content "Email address has already been taken"
  end

end
