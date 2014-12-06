require 'rails_helper'

describe UsersController do
  describe '#edit' do

    it 'users can edit themselves' do
      user = create_user
      session[:user_id] = user.id
      get :edit, id: user
      expect(response).to be_success
    end

    it 'users cannot edit other users' do
      user = create_user
      user_2 = create_user
      session[:user_id] = user.id
      get :edit, id: user_2
      expect(response.status).to eq(404)
    end

  end
end
