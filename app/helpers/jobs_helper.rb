module JobsHelper
  def job_location(job)
    province = job.restaurant.province
    country_code = ISO3166::Country[job.restaurant.country]&.alpha2 || job.restaurant.country
    "#{country_code}, #{province}"
  end

  def formatted_schedule(date, hour_start, hour_end)
    formatted_date = I18n.l(date, format: '%a %d/%m/%y') # Utiliza la configuración de días de la semana en español
    "#{formatted_date} | #{hour_start.strftime('%H:%M')} - #{hour_end.strftime('%H:%M')}"
  end

  def hours_difference(start_time, end_time)
    # Ajustar si end_time es antes que start_time
    if end_time < start_time
      end_time += 1.day
    end

    total_hours = ((end_time - start_time) / 3600.0).round(1)  # Calcular la diferencia en horas con un decimal
    rounded_hours = (total_hours * 2).round / 2.0  # Redondear al múltiplo más cercano de 0.5
    rounded_hours.to_i == rounded_hours ? rounded_hours.to_i : rounded_hours  # Mostrar como entero si no hay fracción
  end

  def time_remaining_formatted(seconds)
    hours = (seconds / 3600).to_i
    minutes = ((seconds % 3600) / 60).to_i
    secs = (seconds % 60).to_i
    format('%02d:%02d:%02d', hours, minutes, secs)
  end
end
