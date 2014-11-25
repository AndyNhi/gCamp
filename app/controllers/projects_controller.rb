class ProjectsController < ApplicationController

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
      redirect_to projects_path
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

end
