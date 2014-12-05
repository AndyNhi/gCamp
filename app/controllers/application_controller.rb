require 'csv'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  before_action :validates_user_is_present

  def validates_user_is_present
    redirect_to signin_path, notice: "You must be logged in to access that information" unless current_user.present?
  end

  class AccessDenied < StandardError; end

  rescue_from AccessDenied, with: :record_not_found

  private

  def record_not_found
    render file: 'public/404', status: :not_found, layout: false
  end


end
