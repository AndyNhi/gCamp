class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    @membership = @project.memberships.new(params.require(:membership).permit(:role, :user_id, :project_id))
    if @membership.save
      redirect_to project_memberships_path(@project, @membership)
    else
      @error_messages = @membership.errors.full_messages
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    @membership.update(params.require(:membership).permit(:role, :user_id, :project_id))
    redirect_to project_memberships_path(@project, @membership)
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project, @membership)
  end


end
