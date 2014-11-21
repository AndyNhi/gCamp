class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index

    if params[:status] == "all" || params[:status] == ""
      @tasks = @project.tasks.order(params[:sort]).page(params[:page])
    elsif params[:status] == "incomplete"
      @tasks = @project.tasks.where(complete: false).order(params[:sort]).page(params[:page])
    else
      @tasks = @project.tasks.where(complete: false).order(params[:sort]).page(params[:page])
    end
    # csv(@tasks)


  end

  def show
    @comment = @task.comments.new
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      @error_messages = @task.errors.full_messages
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      @error_messages = @task.errors.full_messages
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
    def csv(file)
                  file
                  respond_to do |format|
                    format.html
                    format.csv do
                                headers['Content-Disposition'] = "attachment; filename=\"task-list\""
                                headers['Content-Type'] ||= 'text/csv'
                               end
                             end
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :due_date, :complete)
    end
end
