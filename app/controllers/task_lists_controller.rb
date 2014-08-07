class TaskListsController < ApplicationController

  def index
    @task_lists = TaskList.order(:name)
  end

  def new
    @task_list = TaskList.new
    render :new
  end

  def create
    @task_list = TaskList.new(name: "#{params[:task_list][:name]}")
    if @task_list.save
      flash[:notice] = "Task List was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task_list = TaskList.find(params[:id])
    render :edit
  end

  def update
    @task_list = TaskList.find(params[:id])
    if @task_list.update(name: "#{params[:task_list][:name]}")
      flash[:notice] = "Task List was updated successfully!"
      redirect_to root_path
    else
      render :edit
    end

  end

end