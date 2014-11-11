class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:status] == "all" || params[:status] == ""
      @tasks = Task.order(params[:sort]).page(params[:page])
    elsif params[:status] == "incomplete"
      @tasks = Task.where(complete: false).order(params[:sort]).page(params[:page])
    else
      @tasks = Task.where(complete: false).order(params[:sort]).page(params[:page])
    end
    csv(@tasks)

  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      @error_messages = @task.errors.full_messages
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
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
