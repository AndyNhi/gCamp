require 'rails_helper'

describe TasksController do

  describe '#index' do

    it 'renders the index template if admin' do
      project = create_project
      user = create_user(admin: true)
      session[:user_id] =  user.id
      get :index, project_id: project
      expect(response).to render_template('index')
    end

    it 'renders the index template if owner' do
      project = create_project
      user = create_user
      membership = create_membership(project_id: project.id, user_id: user.id, role: 'Owner')
      session[:user_id] = user.id
      get :index, project_id: project
      expect(response).to render_template('index')
    end

    it 'renders the index template if member' do
      project = create_project
      user = create_user
      membership = create_membership(project_id: project.id, user_id: user.id)
      session[:user_id] = user.id
      get :index, project_id: project
      expect(response).to render_template('index')
    end

    it 'responds as 404 if non-member of task/project' do
      project = create_project
      user = create_user
      session[:user_id] = user.id
      get :index, project_id: project
      expect(response.status).to eq(404)
    end

    it 'redirect a non-user to sign in path' do
      project = create_project
      get :index, project_id: project
      expect(response).to redirect_to(signin_path)
    end

  end


  describe '#show' do

    it 'task as owner' do
      user = create_user(admin: true)
      project = create_project
      membership = create_membership(project: project, user: user)
      task = create_task(project: project)
      session[:user_id] = user.id
      get :show, project_id: project, id: task
      expect(response).to be_success
    end

    it 'task as owner' do
      user = create_user
      project = create_project
      membership = create_membership(project: project, user: user, role: 'Owner')
      task = create_task(project: project)
      session[:user_id] = user.id
      get :show, project_id: project, id: task
      expect(response).to be_success
    end


    it 'task as member' do
      user = create_user
      project = create_project
      membership = create_membership(project: project, user: user, role: 'Member')
      task = create_task(project: project)
      session[:user_id] = user.id
      get :show, project_id: project, id: task
      expect(response).to be_success
    end

    it 'responds as 404 if non-member of task/project' do
      user = create_user
      project = create_project
      task = create_task(project: project)
      session[:user_id] = user.id
      get :show, project_id: project, id: task
      expect(response.status).to eq(404)
    end


    it 'redirect a non-user to sign in path' do
      project = create_project
      task = create_task(project: project)
      get :show, project_id: project, id: task
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

    it 'responds as 404 if non-member of task/project' do
      user = create_user
      project = create_project
      task = create_task(project: project)
      session[:user_id] = user.id
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(response.status).to eq(404)
    end

    it 'restricts non-user' do
      user = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: user.id, role: 'Member')
      post :create, task: { project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id
      expect(response).to redirect_to signin_path
    end

  end


  describe '#update' do


    it 'task as admin' do
      admin = create_user(admin: true)
      project = create_project
      task = create_task(project: project)
      session[:user_id] = admin.id
      patch :update, task: {project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id, id: task
      expect(flash[:notice]).to match(/^Task was successfully updated./)
    end

    it 'task as owner' do
      owner = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: owner.id, role: 'Owner')
      task = create_task(project: project)
      session[:user_id] = owner.id
      patch :update, task: {project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id, id: task
      expect(flash[:notice]).to match(/^Task was successfully updated./)
    end

    it 'task as member' do
      member = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: member.id, role: 'Owner')
      task = create_task(project: project)
      session[:user_id] = member.id
      patch :update, task: {project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id, id: task
      expect(flash[:notice]).to match(/^Task was successfully updated./)
    end


    it 'responds as 404 if non-member of task/project' do
      user = create_user
      project = create_project
      task = create_task(project: project)
      session[:user_id] = user.id
      patch :update, task: {project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id, id: task
      expect(response.status).to eq(404)
    end

    it 'restricts non-user' do
      user = create_user
      project = create_project
      membership = create_membership(project_id: project.id, user_id: user.id, role: 'Member')
      task = create_task(project: project)
      patch :update, task: {project: project, description: Faker::Lorem.sentence, due_date: '01/01/2999' }, project_id: project.id, id: task
      expect(response).to redirect_to signin_path
    end

  end


  describe '#destroy' do

    it 'task a admin' do
      admin = create_user(admin: true)
      project = create_project
      task = create_task(project: project)
      session[:user_id] = admin.id
      delete :destroy, project_id: project.id, id: task
      expect(project.tasks.count).to eq(0)
    end


    it 'task a owner' do
      owner = create_user
      project = create_project
      membership = create_membership(project: project, user: owner, role: 'Owner')
      task = create_task(project: project)
      session[:user_id] = owner.id
      delete :destroy, project_id: project.id, id: task
      expect(project.tasks.count).to eq(0)
    end


    it 'task a member' do
      member = create_user
      project = create_project
      membership = create_membership(project: project, user: member, role: 'Member')
      task = create_task(project: project)
      session[:user_id] = member.id
      delete :destroy, project_id: project.id, id: task
      expect(project.tasks.count).to eq(0)
    end

    it 'responds as 404 if non-member of task/project' do
      user = create_user
      project = create_project
      user_2 = create_user
      membership = create_membership(project: project, user: user_2, role: 'Owner')
      task = create_task(project: project)
      session[:user_id] = user.id
      delete :destroy, project_id: project.id, id: task
      expect(response.status).to eq(404)
    end

    it 'redirects non user to signin' do
      project = create_project
      user = create_user
      membership = create_membership(project: project, user: user, role: 'Owner')
      task = create_task(project: project)
      delete :destroy, project_id: project.id, id: task
      expect(response).to redirect_to signin_path
    end

  end

end
