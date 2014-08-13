class TasksController < ApplicationController

  def index
    @tasks = Task.order(:name)
  end

  def new
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.new(allowed_parameters)
    @task.task_list_id = params[:task_list_id]

    if @task.save
      flash[:notice] = "Task was created successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
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

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Task was deleted successfully!"
    redirect_to root_path
  end

  def show
    @task_list = TaskList.find(params[:task_list_id])

  end

  private

  def allowed_parameters
    params.require(:task).permit(:name, :date)
  end

end