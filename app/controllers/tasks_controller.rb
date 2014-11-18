class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @tasks = @project.tasks.where(complete: false) #<----------------------------NOT WORKING
    @ref = "incomplete"
    if params[:sort] == "all"
      @tasks = @project.tasks
      @ref = "all"
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
  end

  def new
    @task = @project.tasks.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def create
    @task = @project.tasks.new(task_params)
    @task.complete = false
    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      redirect_to project_tasks_path, notice: 'Task was successfully destroyed.' #check on task_url *************************
    end
  end

  private
    # def set_task
    #   @task = Task.find(params[:id])
    # end

    def task_params
      params.require(:task).permit(:description, :complete, :due_date)
    end
end
