require 'rails_helper'

describe TasksController do

  describe '#index' do

    it 'renders the index template if user' do
      project = create_project
      user = create_user
      membership = create_membership(project_id: project.id, user_id: user.id)
      session[:user_id] = user.id
      get :index, project_id: project
      expect(response).to render_template('index')
    end

    it 'redirect a non-user to sign in path' do
      project = create_project
      get :index, project_id: project
      expect(response).to redirect_to(signin_path)
    end

  end

  describe '#create' do

    it 'task as owner' do
      owner = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: owner.id, role: 'Owner')
      session[:user_id] = owner.id
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(flash[:notice]).to match(/^Task was successfully created./)
    end

    it 'task as admin' do
      admin = create_user(admin: true)
      project = create_project
      membership = create_membership(project_id: project.id, user_id: admin.id)
      session[:user_id] = admin.id
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(flash[:notice]).to match(/^Task was successfully created./)
    end

    it 'task as member' do
      user = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: user.id, role: 'Member')
      session[:user_id] = user.id
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(flash[:notice]).to match(/^Task was successfully created./)
    end

    it 'restricts non-user' do
      user = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: user.id, role: 'Member')
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(response).to redirect_to signin_path
    end

  end


end
