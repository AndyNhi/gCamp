require 'rails_helper'

describe MembershipsController do

  describe '#index' do

    it 'renders membership index template if they are a member of the project' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id)
      session[:user_id] = user.id
      get :index, project_id: project.id
      expect(response).to render_template('index')
    end

    it 'renders 404 redirect if they are not a member of the project' do
      user = create_user
      project = create_project
      session[:user_id] = user.id
      get :index, project_id: project.id
      expect(response.status).to eq(404)
    end

    it 'redirect to sign in if non user' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id)
      get :index, project_id: project.id
      expect(response).to redirect_to(signin_path)
    end

  end


  describe '#update' do

    it 'membership as owner' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      patch :update, project_id: project.id, id: membership_2.id, "membership"=>{"role"=>"Owner"}
      expect(membership_2.reload.role).to eq('Owner')
    end

    it 'membership as admin' do
      admin = create_user(admin: true)
      member = create_user
      project = create_project
      membership = create_membership(user_id: admin.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = admin.id
      patch :update, project_id: project.id, id: membership_2.id, "membership"=>{"role"=>"Owner"}
      expect(membership_2.reload.role).to eq('Owner')
    end

    it 'restricted from members' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Member')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      patch :update, project_id: project.id, id: membership_2.id, "membership"=>{"role"=>"Owner"}
      expect(membership_2.reload.role).to_not eq('Owner')
    end

  end

  describe '#destroy' do

    it 'membership as owner' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      delete :destroy, project_id: project.id, id: membership_2
      expect(project.memberships.count).to eq(1)
    end

    it 'membership as admin' do
      admin = create_user(admin: true)
      member = create_user
      project = create_project
      membership = create_membership(user_id: admin.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = admin.id
      delete :destroy, project_id: project.id, id: membership_2
      expect(project.memberships.count).to eq(1)
    end

    it 'membership as member & current user' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = member.id
      delete :destroy, project_id: project.id, id: membership_2
      expect(project.memberships.count).to eq(1)
    end

    it 'restricted from members' do
      owner = create_user
      member_1 = create_user
      member_2 = create_user
      project = create_project
      membership_owner = create_membership(user: owner, project: project, role: 'Owner')
      membership_member_1 = create_membership(user: member_1, project: project, role: 'Member')
      membership_member_2 = create_membership(user: member_2, project: project, role: 'Member')
      session[:user_id] = member_1
      delete :destroy, project_id: project.id, id: membership_member_2
      expect(response.status).to eq(404)
    end

  end

end
