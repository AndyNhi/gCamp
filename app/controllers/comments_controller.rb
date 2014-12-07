class CommentsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id]) 
  end

  def create
    @comment = @task.comments.new(params.require(:comment).permit(:copy, :user_id, :task_id))
    @comment.user_id = current_user.id
    @comment.save
    redirect_to project_task_path(@project, @task)
  end


end
