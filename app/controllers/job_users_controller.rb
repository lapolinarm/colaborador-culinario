class JobUsersController < ApplicationController
  before_action :authenticate_user!

  def create
    job = Job.find(params[:job_id])
    job_user = JobUser.new(job: job, user: current_user, status: 0)

    if job_user.save
      flash[:notice] = "Has aplicado al trabajo correctamente."
      redirect_to job_path(job)
    else
      flash[:alert] = "Hubo un problema al aplicar al trabajo."
      redirect_to job_path(job)
    end
  end
end
