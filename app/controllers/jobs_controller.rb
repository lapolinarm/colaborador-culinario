class JobsController < ApplicationController
  before_action :set_job, only: %w[show edit update destroy]
  before_action :authenticate_user!
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
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
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
    params.require(:job).permit(:date, :hour_start, :hour_end, :payment_hour, :description, :responsibility, :requirement, :restaurant_id, :job_mode, :function, :job_type)
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def authorize_collaborator!
    unless current_user.collaborator?
      redirect_to root_path, alert: 'Solo los colaboradores pueden aplicar a trabajos.'
    end
  end
end
