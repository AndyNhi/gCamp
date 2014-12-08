require 'rails_helper'

describe ProjectsController do

  describe '#index' do

    it 'renders as user' do
      create_session
      get :index
      expect(response).to render_template('index')
    end

    it 'renders as admin' do
      admin = create_user(admin: true)
      session[:user_id] = admin.id
      get :index
      expect(response).to render_template('index')
    end

    it 'redirects non user to sign in path' do
      get :index
      expect(response).to redirect_to(signin_path)
    end

  end

  describe '#show' do

    it 'project as admin' do
      admin = create_user(admin: true)
      project = create_project
      session[:user_id] = admin.id
      get :show, id: project
      expect(response).to render_template('show')
    end

    it 'project as owner' do
      owner = create_user
      project = create_project
      membership = create_membership(project: project, user: owner, role: 'Owner')
      session[:user_id] = owner.id
      get :show, id: project
      expect(response).to render_template('show')
    end

    it 'project as member' do
      member = create_user
      project = create_project
      membership = create_membership(project: project, user: member, role: 'Member')
      session[:user_id] = member.id
      get :show, id: project
      expect(response).to render_template('show')
    end

    it 'restrict as non-member' do
      member = create_user
      non_member = create_user
      project = create_project
      membership = create_membership(project: project, user: member, role: 'Member')
      session[:user_id] = non_member.id
      get :show, id: project
      expect(response.status).to eq(404)
    end

    it 'redirect non users' do
      project = create_project
      get :show, id: project
      expect(response).to redirect_to(signin_path)
    end

  end

  describe '#edit' do

    it 'project as owner' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to be_success # because owners should be able to see the edit form
    end

    it 'project as admin' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to be_success # because owners should be able to see the edit form
    end


    it 'restricted from members' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response.status).to eq(404)
    end

  end

  describe '#update' do

    it 'project as owner' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
      session[:user_id] = user.id
      patch :update, id: project.id, project: {description: "foo"}
      expect(response).to redirect_to(projects_path)
    end

    it 'project as admin' do
      admin = create_user(admin: true)
      project = create_project
      membership = create_membership(user_id: admin.id, project_id: project.id, role: 'Owner')
      session[:user_id] = admin.id
      patch :update, id: project.id, project: {description: "foo"}
      expect(response).to redirect_to(projects_path)
    end

    it 'restricted from members' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id
      patch :update, id: project.id, project: {description: "foo"}
      expect(response.status).to eq(404)
    end

  end

  describe '#create' do

    it 'project as admin' do
      admin = create_user(admin: true)
      session[:user_id] = admin.id
      post :create, project: { description: Faker::Company.name }
      expect(Project.count).to eq(1)
    end


    it 'project as user' do
      user = create_user
      session[:user_id] = user.id
      post :create, project: { description: Faker::Company.name }
      expect(Project.count).to eq(1)
    end

    it 'redirects to sign in as non user' do
      post :create, project: { description: Faker::Company.name }
      expect(response).to redirect_to(signin_path)
    end



  end




end
