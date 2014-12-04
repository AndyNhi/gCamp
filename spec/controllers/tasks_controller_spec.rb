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


end
