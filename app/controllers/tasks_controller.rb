class TasksController < ApplicationController

  def index
    @tasks = Task.order(:name)
  end

  def new
    @task = Task.new
    render :new
  end

  def create
    @task = Task.new(name: "#{params[:task][:name]}", task_lists_id: "#{params[:task][:task_list_id]}", date: params[:task][:date])
    p "8"*20
    p params
    p "8"*20
    if @task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    render :edit
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(name: "#{params[:task_list][:name]}")
      flash[:notice] = "Task was updated successfully!"
      redirect_to root_path
    else
      render :edit
    end

  end

end