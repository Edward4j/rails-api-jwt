class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = user_tasks

    render json: @tasks
  end

  def new
    @task = user_tasks.new
  end

  def show
    render json: @task
  end

  def create
    @task = user_tasks.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end
  private

  def task_params
    # params.require(:task).permit(:name, :description, :type, :status)
    # params.permit(:name, :description, :type, :status)

    req =  %i(name description status)
    req.each do |k|
      raise ActionController::ParameterMissing.new(k) unless params[k].present?
    end
    whitelisted = params.permit(:name, :description, :status)
  end

  def set_task
    @task = user_tasks.find(params[:id])
  end

  def user_tasks
    current_user.tasks
  end
end
