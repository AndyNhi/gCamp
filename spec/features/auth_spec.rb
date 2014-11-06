require 'rails_helper'

feature "Authentication" do

  def login
    User.create(first_name: 'a', last_name: 'a', email_address: 'a@email.com', password: 'a')
    visit root_path
    click_link('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'a@email.com'
    fill_in 'Password', :with => 'a'
    click_button 'Log In'
    expect(page).to have_content 'Welcome'
  end

  scenario "User can sign up" do

    visit root_path
    click_link('Sign Up')
    visit '/sign-up'
    fill_in 'First name', with: 'test'
    fill_in 'Last name', with: 'test'
    fill_in 'Email address', with: 'test@email.com'
    fill_in 'Password', with: 'test'
    fill_in 'Password confirmation', with: :password
    click_button 'Create User'
    expect(page).to have_content :notice

  end

  scenario "User signs into a session" do
    login
  end

  scenario "User signs out of session" do
    login
    click_link('Sign Out')
    expect(page).to have_content 'Sign In'
  end

end
