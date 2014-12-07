class MembershipsController < ApplicationController

  before_action :authorize_current_user_membership
  before_action :authorize_owner_update, only: [:update]

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    @membership = Membership.new(params.require(:membership).permit(:role, :user_id))
    @membership.project = @project

    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.first_name} was successfully created"
    else
      @error_messages = @membership.errors.full_messages
      @memberships = @project.memberships
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    @membership.update(params.require(:membership).permit(:role, :user_id, :project_id))
    redirect_to project_memberships_path(@project, @membership), notice: "#{@membership.user.first_name} role was updated successfully"
  end


  def destroy
    @membership = Membership.find(params[:id])
    if last_owner?
      redirect_to project_memberships_path(@project, @membership),
      notice: "You can't delete the last owner.  Please add another owner first."
    elsif member?
      if @membership.user.id != current_user.id
        raise AccessDenied
      else
        @membership.destroy
        redirect_to projects_path,
        notice: "You have successfully remove yourself from the project"
      end
    elsif owner?
      @membership.destroy
      redirect_to project_memberships_path(@project, @membership),
      notice: "#{@membership.user.first_name} was removed successfully"
    else
      raise AccessDenied
    end

  end

  private

  def authorize_current_user_membership
    @project = Project.find(params[:project_id])
    unless @project.memberships.where(user_id: current_user.id).exists?
      raise AccessDenied
    end
  end

  def authorize_owner_update
    @project = Project.find(params[:project_id])
    unless owner?
      @membership = @project.memberships.new
      @memberships = @project.memberships.all
      raise AccessDenied
    end
  end

  def last_owner?
    @project = Project.find(params[:project_id])
    @project.memberships.where(role: 'Owner').count == 1 &&
    owner? && @membership.user.id == current_user.id
  end


end
