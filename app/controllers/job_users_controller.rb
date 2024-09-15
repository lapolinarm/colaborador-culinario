class JobUsersController < ApplicationController
  before_action :set_job

  def create
    @job_user = @job.job_users.build(user: current_user)
    if @job_user.save
      redirect_to root_path, notice: 'You have successfully applied to this job.'
    else
      redirect_to job_path(@job), alert: 'There was an error in applying to this job.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end
