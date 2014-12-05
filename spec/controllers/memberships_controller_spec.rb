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

    it 'only project owners can update memberships' do

      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      patch :update, project_id: project.id, id: membership_2.id, "membership"=>{"role"=>"Owner"}
      expect(membership_2.reload.role).to eq('Owner')

    end

    it 'members cannot update memberships' do

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

    it 'only project owners can destroy memberships' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Owner')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      delete :destroy, project_id: project.id, id: membership_2
      expect(project.memberships.count).to eq(1)
    end

    it 'members cannot destory memberships' do
      owner = create_user
      member = create_user
      project = create_project
      membership = create_membership(user_id: owner.id, project_id: project.id, role: 'Member')
      membership_2 = create_membership(user_id: member.id, project_id: project.id, role: 'Member')
      session[:user_id] = owner.id
      delete :destroy, project_id: project.id, id: membership_2
      expect(project.memberships.count).to eq(2)
    end

  end

end
