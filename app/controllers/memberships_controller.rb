class MembershipsController < ApplicationController

  before_action :authorize_current_user_membership
  before_action :authorize_owner, only: [:update, :destroy]
  # before_action :authorize_member_self_delete, only: [:destroy]

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
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project, @membership), notice: "#{@membership.user.first_name} was removed successfully"
  end

private

  def authorize_current_user_membership
    @project = Project.find(params[:project_id])
      unless @project.memberships.where(user_id: current_user.id).exists?
        raise AccessDenied
    end
  end

  def authorize_owner
    @project = Project.find(params[:project_id])
      unless @project.memberships.where(user_id: current_user.id, role: 'Owner').exists?
        @membership = @project.memberships.new
        @memberships = @project.memberships.all
        raise AccessDenied
      end
  end

  # def authorize_member_self_delete
    # @project = Project.find(params[:project_id])
      # unless @project.memberships.where(user_id: current_user.id, role: 'Member').exists?
    # end

  # end


end
