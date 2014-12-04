require 'rails_helper'

describe ProjectsController do

  describe '#index' do
    it 'renders the index template' do
      create_session
      get :index
      expect(response).to render_template('index')
    end
    it 'redirects non user to sign in path' do
      get :index
      expect(response).to redirect_to(signin_path)
    end

  end

  describe '#edit' do
    it 'only projects owners can edit projects' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to be_success # because owners should be able to see the edit form
    end
  end

  describe '#edit' do
    it 'members cannot edit projects' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response.status).to eq(404)
    end
  end

  describe '#update' do
    it 'only projects owners can edit projects' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Owner')
      session[:user_id] = user.id
      patch :update, id: project.id, project: {description: "foo"}
      expect(response).to redirect_to(projects_path)
    end
  end

  describe '#update' do
    it 'members cannot update projects' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id
      patch :update, id: project.id, project: {description: "foo"}
      expect(response.status).to eq(404)
    end
  end

end
