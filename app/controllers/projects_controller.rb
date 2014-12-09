class ProjectsController < ApplicationController
  before_action :get_project, except: [:index, :new, :create]
  before_action :current_user_permission, only: [:new, :create]
  before_action :members_only_permission, except: [:index, :new, :create]

  def index
    @projects = Project.all
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

  private

  def current_user_permission

    raise AccessDenied unless current_user
  end

  def members_only_permission
    raise AccessDenied unless @project.memberships.pluck(:user_id).include? current_user.id ||
    current_user.admin
  end

  def get_project
    begin
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      raise AccessDenied
    end
  end


end
