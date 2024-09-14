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
    @jobs = Job.all
    if params[:job_id].present?
      @selected_job = Job.find(params[:job_id])
      @time_remaining = calculate_time_remaining(@selected_job)
    else
      @selected_job = nil
      @time_remaining = nil
    end

    @job_user = JobUser.new
  end

  def about
  end

  def application
    if current_user.owner?
      @restaurants = current_user.restaurants
      if params[:date].present? || params[:restaurant_id].present?
        @restaurants = @restaurants.joins(:jobs).where(jobs: { date: params[:date] }) if params[:date].present?
        @restaurants = @restaurants.where(id: params[:restaurant_id]) if params[:restaurant_id].present?
      end
      render 'owners_dashboard'
    elsif current_user.collaborator?
      @applied_jobs = current_user.jobs
      @all_applied_jobs = @applied_jobs
      @applied_jobs = @applied_jobs.where(job_users: { status: params[:status] }) if params[:status].present?
      render 'pages/application'
    else
      redirect_to root_path
    end
  end

  private

  def calculate_time_remaining(job)
    current_time = Time.current
    return "Datos inválidos" if job.date.nil? || job.hour_start.nil?

    job_datetime = job.date.to_time.change(hour: job.hour_start.hour, min: job.hour_start.min)

    if job_datetime < current_time
      "Oferta expirada"
    else
      remaining_seconds = (job_datetime - current_time).to_i
      hours = remaining_seconds / 3600
      minutes = (remaining_seconds % 3600) / 60
      seconds = remaining_seconds % 60
      { hours: hours, minutes: minutes, seconds: seconds }
    end
  end

end
