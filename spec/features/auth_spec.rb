require 'rails_helper'

feature "Authentication" do

  def login
    user = create_user
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', with: user.email_address
    fill_in 'Password', with: user.password
    click_on 'Log In'
    expect(page).to have_content( 'Welcome')
  end

  scenario "sign up" do
    visit root_path
    click_on('Sign Up')
    visit '/sign-up'
    fill_in 'First name', with: 'test'
    fill_in 'Last name', with: 'test'
    fill_in 'Email address', with: 'test@email.com'
    fill_in 'Password', with: 'test'
    fill_in 'Password confirmation', with: :password
    click_on 'Create User'
    expect(page).to have_content :notice
  end

  scenario "create session" do
    login
  end

  scenario "destroy session" do
    login
    click_on('Sign Out')
    expect(page).to have_content 'Sign In'
  end

end
