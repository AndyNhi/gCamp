class TrackerProjectsController < ApplicationController

  def show
    project_id = params[:id]
    tracker_api = TrackerProject.new
    @pivotol_stories_per_project = tracker_api.stories(project_id, current_user.pivotal_tracker_token)
    @pivotal_stories_project_name = tracker_api.project(project_id, current_user.pivotal_tracker_token)
  end


end
