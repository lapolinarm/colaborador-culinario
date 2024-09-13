class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @jobs = Job.all
    if params[:job_id].present?
      @selected_job = Job.find(params[:job_id])
      @time_remaining = calculate_time_remaining(@selected_job)
    else
      @selected_job = nil
      @time_remaining = nil
    end
  end

  def about
  end

  def dashboard
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
