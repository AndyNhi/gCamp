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
    @project.update(params.require(:project).permit(:description))
    redirect_to projects_path, notice: 'Task was successfully updated.'

  end


  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Task was successfully destroyed.' }
    end
  end

end
