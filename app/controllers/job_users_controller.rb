class JobUsersController < ApplicationController
  before_action :set_job

  def create
    if @job.job_users.exists?(user: current_user)
      redirect_to root_path(@job), alert: 'Ya has aplicado a este trabajo.'
    else
      @job_user = @job.job_users.build(user: current_user)
      if @job_user.save
        redirect_to root_path, notice: 'Aplicaste al trabajo con éxito.'
      else
        redirect_to job_path(@job), alert: 'Error al aplicar al trabajo.'
      end
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end
