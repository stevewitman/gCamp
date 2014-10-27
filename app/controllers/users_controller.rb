class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @event = Event.new
  end

  def create
    @task = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @event, class: 'alert alert-success' }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
