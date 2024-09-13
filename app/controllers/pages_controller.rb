class PagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:home, :about, :dashboard, :contact]


  def dashboard
    if current_user.owner?
      @restaurants = current_user.restaurants
      if params[:date].present? || params[:restaurant_id].present?
        @restaurants = @restaurants.joins(:jobs).where(jobs: { date: params[:date] }) if params[:date].present?
        @restaurants = @restaurants.where(id: params[:restaurant_id]) if params[:restaurant_id].present?
      end
      render 'owners_dashboard'
    elsif current_user.collaborator?
      @applied_jobs = current_user.jobs
      @applied_jobs = @applied_jobs.where(job_users: { status: params[:status] }) if params[:status].present?
      render 'collaborators_dashboard'
    else
      redirect_to root_path
    end
  end

  def home
  end

  def about
  end
end
