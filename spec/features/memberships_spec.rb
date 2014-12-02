require 'rails_helper'

feature 'Memberships' do

  before(:each) do
    @project = Project.create!(description: 'the event')
    @user = User.create!(first_name: 'Andy', last_name: 'Nguyen', email_address: 'example@email.com', password: 'pass', password_confirmation: 'pass')
  end

  def signin
    visit root_path
    click_on('Sign In')
    visit '/sign-in'
    fill_in 'Email', :with => 'example@email.com'
    fill_in 'Password', :with => 'pass'
    click_on 'Log In'
  end

  scenario "can be added to projects" do
    signin
    visit project_memberships_path(@project)
    select('Andy', from: 'membership_user_id')
    select('Member', from: 'membership_role')
    click_on 'Create Membership'
    expect(page).to have_content(@user.first_name)
  end

  scenario "can be removed from projects" do
    signin
    membership = Membership.create!(project_id: @project.id, user_id: @user.id, role: 'Member')
    visit project_memberships_path(@project)
    click_on 'delete'
    expect(page).to_not have_content(membership.id)
  end

  scenario "can be updated by their roles" do
    signin
    membership = Membership.create!(project_id: @project.id, user_id: @user.id, role: 'Member')
    visit project_memberships_path(@project)
    find("#edit_membership_#{membership.id}").select('Owner', from: 'membership_role')
    click_on 'Update Membership'
    expect(page).to have_content("Owner")
  end

end
