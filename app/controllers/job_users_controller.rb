class JobUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    @job = Job.find(params[:job_id]) # Encuentra el trabajo al que se está aplicando
    @job_user = JobUser.new(user: current_user, job: @job)

    if @job_user.save
      redirect_to job_path(@job), notice: 'Has aplicado exitosamente al trabajo.'
    else
      redirect_to job_path(@job), alert: 'No se pudo aplicar al trabajo.'
    end
  end
end
