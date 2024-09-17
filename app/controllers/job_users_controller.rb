class JobUsersController < ApplicationController
  before_action :set_job

  def create
    @job_user = @job.job_users.build(user: current_user)
    if @job_user.save
      redirect_to root_path, notice: 'Trabajo solicitado con éxito.'
    else
      redirect_to job_path(@job), alert: 'Error.'
    end
  end

  private
  def job_user_params
    params.require(:job_user).permit(:user_id, :job_id, :payment_method_used, :amount_paid)
  end
  def set_job
    @job = Job.find(params[:job_id])
  end
end
