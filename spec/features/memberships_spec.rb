require 'rails_helper'

feature 'Membership' do

  before(:each) do
    @project = create_project
    @user = create_user
  end

  def signin
    visit root_path
    click_on 'Sign In'
    visit '/sign-in'
    fill_in 'Email', with: @user.email_address
    fill_in 'Password', with: @user.password
    click_on 'Log In'
  end

  scenario "users are added as members of a project" do
    signin
    create_membership(user_id: @user.id, project_id: @project.id, role: 'Owner')
    user_2 = create_user
    visit project_memberships_path(@project)
    select(user_2.first_name, from: 'membership_user_id')
    click_on 'Create Membership'
    expect(page).to have_content(user_2.first_name)
  end

  scenario "users are removed as members of a project" do
    signin
    membership = Membership.create!(project_id: @project.id, user_id: @user.id, role: 'Owner')
    visit project_memberships_path(@project)
    click_on 'delete'
    expect(page).to_not have_content(membership.id)
  end

  scenario "the role of each member can be updated" do
    signin
    membership = Membership.create!(project_id: @project.id, user_id: @user.id, role: 'Owner')
    visit project_memberships_path(@project)
    find("#edit_membership_#{membership.id}").select('Owner', from: 'membership_role')
    click_on 'Update Membership'
    expect(page).to have_content("Owner")
  end

end
