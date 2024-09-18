class FavoritesController < ApplicationController
  before_action :set_job

  def create
    @favorite = current_user.favorites.build(job: @job)
    if @favorite.save
      redirect_to job_path(@job), notice: 'El trabajo se agregó exitosamente a tus favoritos.'
    else
      redirect_to job_path(@job), alert: 'Hubo un error al agregar el trabajo a tus favoritos.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end
end
