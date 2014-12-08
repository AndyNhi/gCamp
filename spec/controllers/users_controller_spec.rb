require 'rails_helper'

describe UsersController do

  describe '#index' do

    it 'accessible by admin' do
      admin = create_user(admin: true)
      session[:user_id] = admin.id
      get :index
      expect(response).to render_template('index')
    end

    it 'accessible by user ' do
      user = create_user
      session[:user_id] = user.id
      get :index
      expect(response).to render_template('index')
    end

    it 'redirect non users to signin path' do
      get :index
      expect(response).to redirect_to(signin_path)
    end

  end

  describe '#show' do

    it 'user as admin' do
      admin = create_user(admin: true)
      user = create_user
      session[:user_id] = admin.id
      get :show, id: user
      expect(response).to render_template('show')
    end

    it 'user as user' do
      user = create_user
      session[:user_id] = user.id
      get :show, id: user
      expect(response).to render_template('show')
    end

    it 'redirect non users to signin path' do
      user = create_user
      get :show, id: user
      expect(response).to redirect_to(signin_path)
    end

  end


  describe '#new' do

    it 'users as admin' do
      admin = create_user(admin: true)
      session[:user_id] = admin.id
      get :new
      expect(response).to render_template('new')
    end

    it 'redirect non users to signin path' do
      get :new
      expect(response).to redirect_to(signin_path)
    end

    it '404 as user non-admin' do
      user = create_user
      session[:user_id] = user.id
      get :new
      expect(response.status).to eq(404)
    end

  end


  describe '#create' do

    it 'admin as admin' do
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

  describe '#destroy' do

    it 'users as admin' do
      admin = create_user(admin: true)
      user = create_user
      session[:user_id] = admin.id
      delete :destroy, id: user
      expect(User.all.count).to eq(1)
    end

    it 'current_user as current_user in session' do
      user = create_user
      session[:user_id] = user.id
      delete :destroy, id: user
      expect(User.all.count).to eq(0)
    end

    it 'raises error if other user attempts to delete another user' do
      user = create_user
      user_2 = create_user
      session[:user_id] = user.id
      delete :destroy, id: user_2
      expect(response.status).to eq(404)
    end

    it 'redirects non users to sign in' do
      user = create_user
      delete :destroy, id: user
      expect(response).to redirect_to(signin_path)
    end

  end

end
