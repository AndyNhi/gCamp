require 'rails_helper'

feature "User Crud" do

  before(:each) do
    @user = create_user
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

  scenario "create user" do
    visit users_path
    click_on 'Create User'
    fill_in 'First name', with: 'Johnny'
    fill_in 'Last name', with: 'Cash'
    fill_in 'Email address', with: 'Johnny@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Create User'
    expect(page).to have_content 'User was successfully created.'
  end

  scenario "show user" do
    visit '/users'
    click_on "#{@user.first_name} #{@user.last_name}"
    expect(page).to have_content @user.first_name
  end

  scenario "update user" do
    visit "/users"
    click_on "Edit"
    fill_in "First name", with: "Andy"
    click_on "Update User"
    expect(page).to have_content "Andy"
  end

  scenario "destroy user" do
    visit "/users"
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content "Andy"
  end

  scenario "outputs error messages are recieved if validation are not present" do
    visit "/users"
    click_on "Create User"
    click_on "Create User"
    expect(page).to have_content "prohibited"
  end

  scenario "outputs error message with email duplication" do
    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "test"
    fill_in "Last name", with: "test"
    fill_in "Email address", with: @user.email_address
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content "Email address has already been taken"
  end

end
