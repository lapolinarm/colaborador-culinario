class JobsController < ApplicationController
  before_action :set_job, only: %w[show edit update destroy]
  before_action :authenticate_user!
  before_action :set_restaurant, only: %w[new create]
  before_action :authorize_collaborator!, only: [:apply]

  def apply
    # Lógica para aplicar a un trabajo
  end

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = @restaurant.jobs.new
  end

  def create
    @job = @restaurant.jobs.new(job_params)
    puts job_params # Esto te permitirá ver los parámetros en la consola

    if @job.save
      redirect_to job_path(@job), notice: "Job was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to job_path(@job), notice: "Job was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to application_path(user: current_user), notice: "Job was successfully deleted."
  end

  private

  def job_params
    params.require(:job).permit(:date, :hour_start, :hour_end, :payment_hour, :description, :responsibility, :requirement, :restaurant_id)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id]) if params[:restaurant_id].present?
  end

  def authorize_collaborator!
    unless current_user.collaborator?
      redirect_to root_path, alert: 'Solo los colaboradores pueden aplicar a trabajos.'
    end
  end
end
