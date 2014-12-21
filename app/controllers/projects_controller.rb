class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  # before_action :authorize_member, only: [:show, :destroy]
  # before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
    tracker_api = TrackerAPI.new
    @tracker_projects = tracker_api.projects(current_user.pivotal_tracker_token)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    project_params = params.require(:project).permit(:name)
    @project = Project.new(project_params)
    if @project.save
      Membership.create!(
                  project: @project,
                  user_id: current_user.id,
                  role: "Owner"
                  )
      redirect_to project_tasks_path(@project), notice: 'Project was sucessfully created'
    else
      render :new
    end

  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project_params = params.require(:project).permit(:name)
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to project_path(@project), notice: 'Project was sucessfully updated'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was sucessfully deleted'
  end

  def role?(project, role)
    project.memberships.pluck(:user_id).include? current_user.id && current_user.role == role
  end

  def owner?(project)
    memberships.where(project_id: project, role: "Owner").present?
  end

  def tracker_stories
    tracker_api = TrackerAPI.new
    @tracker_stories = tracker_api.stories(current_user.pivotal_tracker_token, params[:tracker_id])
  end

  private

  def authorize_member
    raise AccessDenied unless @project.memberships.where(role: "Member").pluck(:user_id).include? current_user.id || current_user.admin
  end

  def authorize_owner
    raise AccessDenied unless @project.memberships.where(role: "Owner").pluck(:user_id).include? current_user.id || current_user.admin
  end

  def set_project
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      raise AccessDenied
    end
  end

end
