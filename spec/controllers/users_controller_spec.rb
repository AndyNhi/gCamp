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

  describe '#create' do

    it 'only allows admins to create users with admin role' do
      skip
      user = create_user(admin: true)
      user_2 = User.new(
        first_name: 'Andy',
        last_name: 'Nguyen',
        email_address: 'Blah@email.com',
        password: 'password',
        admin: true )
      session[:user_id] = user.id
      post :create, user_2
      expect(response).to be_success
    end

    it 'users cannot create users with admin role' do
      skip
    end

  end

  describe '#update' do
    it 'only admins can update the admin role' do
      skip
    end

    it 'users cannot update admin role'do
      skip
    end
  end

end
