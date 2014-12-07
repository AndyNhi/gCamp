require 'rails_helper'

describe UsersController do

  describe '#create' do

    it 'admins as admin' do
      user = create_user(admin: true)
      session[:user_id] = user.id
      post :create, user: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email_address: Faker::Internet.email, password: 'password', admin: true}
      expect(flash[:notice]).to match(/^User was successfully created./)
    end

    it 'restriction of admin role when user' do
      user = create_user
      session[:user_id] = user.id
      post :create, user: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email_address: Faker::Internet.email, password: 'password', admin: true}
      expect(response.status).to eq(404)
    end

  end

  describe '#edit' do

    it 'user when current_user' do
      user = create_user
      session[:user_id] = user.id
      get :edit, id: user
      expect(response).to be_success
    end

    it 'restriction to other users when user' do
      user = create_user
      user_2 = create_user
      session[:user_id] = user.id
      get :edit, id: user_2
      expect(response.status).to eq(404)
    end

  end

  describe '#update' do
    it 'admin role as admin' do
      user = create_user(admin: true)
      user_2 = create_user
      session[:user_id] = user.id
      post :update, id: user, user: { first_name: user_2.first_name, last_name: user_2.last_name, email_address: user_2.email_address, admin: true, password: user_2.password}
      expect(response).to be_success
    end

    it 'restricted admin role update when user'do
      user = create_user
      user_2 = create_user
      session[:user_id] = user.id
      post :update, id: user, user: { first_name: user_2.first_name, last_name: user_2.last_name, email_address: user_2.email_address, admin: true, password: user_2.password}
      expect(user_2[:admin]).to eq(false)
    end

  end

end
