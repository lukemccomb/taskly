class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.order(:name)
  end

  def create_page
    @task_list = TaskList.new
    render :create_task_list
  end

  def create
    @task_list = TaskList.create(name: "#{params[:task_list][:name]}")
    if @task_list.valid?
      flash[:notice] = "Task List was created successfully!"
      redirect_to root_path
    else
      flash[:error] = "Your task list could not be created"
      render :create_task_list
    end
  end

end