class ProjectsController < ApplicationController

  before_action :authorize_member, only: [:show]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:description))
    if @project.save
      Membership.create(project_id: @project.id, user_id: current_user.id, role: "Owner")
      redirect_to project_tasks_path(@project)
    else
      @error_messages = @project.errors.full_messages
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(params.require(:project).permit(:description))
      redirect_to projects_path, notice: 'Project was successfully updated.'
    else
      @error_messages = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end

private

  def authorize_member
    @project = Project.find(params[:id])
    unless @project.memberships.where(user_id: current_user.id).exists?
      render file: 'public/404', status: :not_found, layout: false
    end
  end

  def authorize_owner
    @project = Project.find(params[:id])
      unless @project.memberships.where(user_id: current_user.id, role: 'Owner').exists?
        render file: 'public/404', status: :not_found, layout: false
    end
  end



end
