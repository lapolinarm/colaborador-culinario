class PagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:home, :about, :dashboard, :contact]

  def retur_campo
    {
      presencial: 'job_mode',
      hibrido: 'job_mode',
      fulltime: 'job_type',
      parttime: 'job_type',
      range1: 'payment_hour',
      range2: 'payment_hour',
      mozo: 'function',
      azafata: 'function',
      delivery: 'function',
      lavaplatos: 'function'
    }
  end

  def retur_valor
    {
      presencial: 0,
      hibrido: 1,
      fulltime: 0,
      parttime: 1,
      range1: 20..30,
      range2: 40..50,
      mozo: 0,
      azafata: 1,
      delivery: 2,
      lavaplatos: 3
    }
  end

  def validar_repetidos(val_categories)
    array_camp_repet = []
    val_categories.each do |val|
      array_camp_repet << retur_campo[val.to_sym]
    end
    val_duplicates = array_camp_repet.length != array_camp_repet.uniq.length
  end

  def ordenar_campos(ingreso_campos)
    camp_resultado = []
    campos_ordenados = ["presencial", "hibrido", "fulltime", "parttime", "range1", "range2", "mozo", "azafata", "delivery", "lavaplatos"]

    campos_ordenados.each do |x|
      if ingreso_campos.include?(x)
        index_temp = ingreso_campos.index(x)
        camp_resultado << ingreso_campos[index_temp]
      end
    end
    camp_resultado
  end

  def obtener_hash_completo_consulta(camp_ordenados)
    camp_tem =
    hash_resutl = {}
    valor = []

    camp_ordenados.each_with_index do |element, index|
      campo = retur_campo[element.to_sym]
      camp_tem = index == 0 ? retur_campo[camp_ordenados[0].to_sym] : retur_campo[camp_ordenados[index - 1].to_sym]

      if camp_tem.eql? campo
        valor << retur_valor[element.to_sym]
        hash_resutl[campo.to_sym] = valor
      else
        valor_temp = []
        valor_temp << retur_valor[element.to_sym]
        hash_resutl[campo.to_sym] = valor_temp
      end
    end
    hash_resutl
  end

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
    if params[:filter]
      permitted_params = params.require(:filter).permit(categories: [])
      categories = permitted_params[:categories]
      query_hash = {}

      if validar_repetidos(categories)
        camps_ordenados = ordenar_campos(categories)
        hash_camp_ordenados = obtener_hash_completo_consulta(camps_ordenados)
        puts "campos ordenados -> #{hash_camp_ordenados}"

        hash_camp_ordenados.each do |clave, valor|
          query_hash[clave.to_sym] = valor
        end
        @jobs = Job.where(query_hash)

      else
        categories.each do |categorie|
          query_hash[retur_campo[categorie.to_sym].to_sym] = retur_valor[categorie.to_sym]
        end
        puts "campos query hash -> #{query_hash}"
        @jobs = Job.where(query_hash)
      end
    else
      # Filtrar empleos que no han expirado (criterio 1)
      @jobs = Job.where("date > ? OR (date = ? AND hour_start > ?)", Date.current, Date.current, Time.current)
      .order(:date, :hour_start)  # Ordenar por fecha y hora de inicio, más próximos primero

      Rails.logger.debug("Parámetro 'filter' no está presente.")
    end

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


    if current_user.owner?
      @restaurants = current_user.restaurants
      if params[:date].present? || params[:restaurant_id].present?
        @restaurants = @restaurants.joins(:jobs).where(jobs: { date: params[:date] }) if params[:date].present?
        @restaurants = @restaurants.where(id: params[:restaurant_id]) if params[:restaurant_id].present?
      end
      render 'owners_dashboard'
    elsif current_user.collaborator?
      @applied_jobs = current_user.jobs.order('jobs.date ASC')
      @my_payments = @applied_jobs.where(job_users: { status: "aceptado" }).order('jobs.date ASC')
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
