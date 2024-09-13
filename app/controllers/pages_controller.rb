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
    @jobs = Job.includes(:restaurant).all
    @selected_job = Job.find(params[:job_id]) if params[:job_id].present?

    if @selected_job
      @time_remaining = calculate_time_remaining(@selected_job)
    else
      @time_remaining = 0
    end

    @job_user = JobUser.new
  end

  def about
  end

  def dashboard
  end

  def calculate_time_remaining(job)
    now = Time.current
    job_date = job.date.to_time

    # Combina la fecha con la hora de inicio y fin
    start_time = job_date.change(hour: job.hour_start.hour, min: job.hour_start.min)
    end_time = job_date.change(hour: job.hour_end.hour, min: job.hour_end.min)

    # Si la hora de fin es antes de la hora de inicio, se asume que es el día siguiente
    end_time += 1.day if end_time < start_time

    # Calcula el tiempo restante
    if now < start_time
      return (start_time - now).to_i
    elsif now > end_time
      return 0
    else
      return (end_time - now).to_i
    end
  end

end
