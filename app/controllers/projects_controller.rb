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
    @project = Project.new(:project)
    @project.save
    redirect_to projects_path
  end

  def update
    @project = Project.find(params[:id])
    @project.update(params.require(:project).permit(:description))
    redirect_to projects_path
  end


  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Task was successfully destroyed.' }
    end
  end

end
