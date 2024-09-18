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
    # Filtrar empleos que no han expirado (criterio 1)
    @jobs = Job.where("date > ? OR (date = ? AND hour_start > ?)", Date.current, Date.current, Time.current)
               .order(:date, :hour_start)  # Ordenar por fecha y hora de inicio, más próximos primero

    if user_signed_in?
      # Excluir empleos a los que el usuario ya se ha postulado (criterio 2)
      applied_job_ids = current_user.jobs.pluck(:id)
      @jobs = @jobs.where.not(id: applied_job_ids)
    end

    # Verificar si no hay empleos disponibles después de aplicar los filtros
    if @jobs.empty?
      flash.now[:notice] = "No hay empleos disponibles en este momento."
    end

    # Si hay un empleo seleccionado, calcular el tiempo restante
    if params[:job_id].present?
      @selected_job = Job.find(params[:job_id])
      @time_remaining = calculate_time_remaining(@selected_job)
    else
      @selected_job = @jobs.first
      @time_remaining = @selected_job.present? ? calculate_time_remaining(@selected_job) : nil
    end

    @job_user = JobUser.new
  end

  def about
  end

  def application

    @array = []


    10.times do
      @array << Faker::Number.between(from: 1, to: 10)
    end

    puts @array




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
