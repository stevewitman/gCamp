class TasksController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @tasks = @project.tasks.where(complete: false)#<----------------------------NOT WORKING
    @ref = "incomplete"
    if params[:sort] == "all"
      @tasks = @project.tasks
      @ref = "all"
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def edit
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    @task.complete = false
    if @task.save
      redirect_to project_tasks_path(@project), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.destroy
      redirect_to project_tasks_path, notice: 'Task was successfully removed.' #check on task_url *************************
    end
  end

  def create_comment
    @task = Task.find(params[:task_id])
    if current_user
      comment_params = params.require(:comment).permit(:content, :user_id, :task_id)
      @comment = @task.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      redirect_to project_task_path(@task.project_id, @task)
    else
      #
      render :show
    end
  end





  private

    def task_params
      params.require(:task).permit(:description, :complete, :due_date)
    end
end
