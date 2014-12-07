require 'csv'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    User.find_by(id: session[:user_id])
  end

  def admin?
    current_user.admin == true
  end

  def owner?
    @project.memberships.where(role: 'Owner', user_id: current_user).exists? || admin?
  end

  def member?
    @project.memberships.where(role: 'Member', user_id: current_user).exists? || admin?
  end

  def current_user_member?
    @project.memberships.where(user_id: current_user).exists? || admin?
  end

  def guest?
    current_user == nil
  end


  def validates_user_is_present
    redirect_to signin_path, notice: "You must be logged in to access that information" unless current_user.present?
  end

  def record_not_found
    render file: 'public/404', status: :not_found, layout: false
  end

  helper_method :current_user
  helper_method :admin?
  helper_method :owner?
  helper_method :member?
  helper_method :current_user_member?
  helper_method :guest

  before_action :validates_user_is_present

  class AccessDenied < StandardError; end

  rescue_from AccessDenied, with: :record_not_found

  private


end
