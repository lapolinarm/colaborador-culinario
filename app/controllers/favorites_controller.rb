class FavoritesController < ApplicationController
  before_action :set_job

  def create
    @favorite = current_user.favorites.build(job: @job)
    if @favorite.save
      redirect_to job_path(@job), notice: 'Job was successfully added to your favorites.'
    else
      redirect_to job_path(@job), alert: 'There was an error adding the job to your favorites.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end
