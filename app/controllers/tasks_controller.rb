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
    @show_page = true
  end

  def new
    @new_page = true
    @task = Task.new
  end

  def edit
    @edit_page = true
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.'}
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
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
