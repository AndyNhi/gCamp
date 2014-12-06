class UsersController < ApplicationController

  skip_before_action :validates_user_is_present, only: [:new, :create, :signup]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def set_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def signup
    @user = User.new
  end

  def edit
  end

  def create
    if authorized_admin?
      @user = User.new(params.require(:user).permit( :first_name, :last_name, :email_address, :password, :password_confirmation, :admin))
      if @user.save
        session[:user_id] = @user.id
        redirect_to new_project_path, notice: 'User was successfully created.'
      else
        @error_messages = @user.errors.full_messages
        render :new
      end
    else
      raise AccessDenied
    end
  end

  def update
    if authorized_admin?
      if @user.update(params.require(:user).permit(:first_name, :last_name,:email_address, :password, :password_confirmation, :admin))
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    elsif authorized_user?
      if @user.update(params.require(:user).permit(:first_name, :last_name,:email_address, :password, :password_confirmation))
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      raise AccessDenied
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

private

  def authorize_user
    @user = User.find(params[:id])
      unless @user.id == current_user.id
        raise AccessDenied
      end
  end

  def authorized_admin?
    current_user.admin == true
  end

  def authorized_user?
    current_user.admin == false
  end



end
