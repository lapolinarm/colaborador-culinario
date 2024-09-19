class Util
  #Cosntants
  EMPRENDEDOR = 0
  COLABORADOR = 1

  MOZO        = 0
  AZAFATA     = 1
  DELIVERY    = 2
  LAVAPLATOS  = 3

  def returnDescriptionJob(val_funct)
    case val_funct
    when MOZO
      "Recibir, tomar solicitudes y pedidos y atender al cliente conforme a sus necesidades, de acuerdo a la disponibilidad de los productos e insumos"
    when AZAFATA
      "Recibir, tomar solicitudes y pedidos y atender al cliente conforme a sus necesidades, de acuerdo a la disponibilidad de los productos e insumos"
    when DELIVERY
      "Realiza el transporte y la distribución de productos del lugar de elaboración, venta o almacenamiento hasta el domicilio donde se consumirán en unas condiciones óptimas y en unos márgenes de tiempo aceptables"
    when LAVAPLATOS
      "Responsable de limpiar los platos, las vasijas y demás utensilios de cocina prestando su apoyo a las personas que elaboran la comida y en las que trabajan en sala o comedores"
    else
      "Requisito no especificado para #{val_funct}"
    end
  end

  def returnresponsibilityJob(val_funct)
    case val_funct
    when MOZO
      "Atención cortés y educada, enfatizando la calidad y rapidez"
    when AZAFATA
      "Atención cortés y educada, enfatizando la calidad y rapidez"
    when DELIVERY
      "Entrega de productos de manera rápida y eficiente"
    when LAVAPLATOS
      "Eficiente limpieza de los objetos usados"
    else
      "Requisito no especificado para #{val_funct}"
    end
  end

  def returnRequirementJob(val_funct)
    case val_funct
    when MOZO
      "Varón de 16 años a más"
    when AZAFATA
      "Mujer de 17 en adelante"
    when DELIVERY
      "Varón de 18 en adelante con algún medio de transporte(Moto, Bicicleta)"
    when LAVAPLATOS
      "Varón o mujer de 16 para adelante"
    else
      "Requisito no especificado para #{val_funct}"
    end
  end

  def returnRestaurants
    [
      "Central (Lima)",
      "Maido (Lima)",
      "Osso (Lima)",
      "Astrid y Gastón (Lima)",
      "Panchita (Lima)",
      "La Mar (Lima)",
      "El Mercado (Lima)",
      "Rafael (Lima)",
      "El Pan de la Chola (Lima)",
      "Baco (Lima)",
      "Fiesta (Lima)",
      "La Picantería (Lima)",
      "El Reloj (Lima)",
      "El Faraón (Lima)",
      "Sabor a Perú (Lima)",
      "Santos (Lima)",
      "Virgilio (Lima)",
      "El Señorío de Sulco (Lima)",
      "El Bodegón (Lima)",
      "Aromas del Perú (Lima)",
      "El Muelle (Lima)",
      "El Califa (Lima)",
      "Bistro 400 (Lima)",
      "Canta Rana (Lima)",
      "Sazón Peruana (Lima)",
      "Don Mamino (Lima)",
      "Zuma (Lima)",
      "Pisco (Lima)",
      "Costanera 700 (Lima)",
      "La Lucha Sanguchería (Lima)",
      "El Chinito (Lima)",
      "Los Bachiche (Lima)",
      "Pisco y Nazca (Lima)",
      "La 73 (Lima)",
      "El Carajo (Lima)",
      "Salamanca (Lima)",
      "El Tapeo (Lima)",
      "Sabor y Estilo (Lima)",
      "La Casa de la Cerveza (Lima)",
      "El Joven Luchador (Lima)",
      "Tanta (Lima)",
      "La Picantería (Lima)",
      "Canta Rana (Lima)",
      "Mediterráneo (Lima)",
      "Los Cuentos de la Abuela (Lima)",
      "Costanera 700 (Lima)",
      "La Pólvora (Lima)",
      "El Rincón que No Conoces (Lima)",
      "El Restaurante (Lima)",
      "Pisco Bar (Lima)",
      "Sushi Maki (Lima)",
      "Chicha (Cusco)",
      "MAP Café (Cusco)",
      "Cicciolina (Cusco)",
      "Uchu Peruvian Steakhouse (Cusco)",
      "Limo (Cusco)",
      "Apu Restaurant (Cusco)",
      "Inka Grill (Cusco)",
      "Café Del Museo (Cusco)",
      "Pizzeria Nativo (Cusco)",
      "La Bodega 138 (Cusco)",
      "Kintaro (Cusco)",
      "DonAntonio (Cusco)",
      "Café Túpac (Cusco)",
      "El Encuentro (Cusco)",
      "Pacha Papa (Cusco)",
      "Chaskana (Cusco)",
      "La Cúpula (Cusco)",
      "El Tío Mario (Cusco)",
      "Café Tinkuy (Cusco)",
      "Nuna Raymi (Cusco)",
      "Los Toldos (Cusco)",
      "Qespi (Cusco)",
      "Café Cusi (Cusco)",
      "Café Tahuantinsuyo (Cusco)",
      "Green Point (Cusco)",
      "Jack's Café (Cusco)",
      "Café de los Abuelos (Cusco)",
      "Café del Parque (Cusco)",
      "Choco Museo (Cusco)",
      "La Casa de la Carne (Cusco)",
      "Pachapapa (Cusco)",
      "L'Atelier (Cusco)",
      "Santo Bar (Cusco)",
      "Sabor de mi Tierra (Cusco)",
      "Café Bodega (Cusco)",
      "La Pérgola (Cusco)",
      "Café Misk'i (Cusco)",
      "Hanan Pacha (Cusco)",
      "Chayña (Cusco)",
      "El Alma (Cusco)",
      "El Barquero (Cusco)",
      "La Rana (Cusco)",
      "Los Cangrejos (Tacna)",
      "Picantería La Huerta (Tacna)",
      "La Fonda del Pueblo (Tacna)",
      "La Casa de la Cerveza (Tacna)",
      "Mamma Mia (Tacna)",
      "El Buen Sazón (Tacna)",
      "Cevichería El Pescador (Tacna)",
      "Restaurante Chifa Chung Wah (Tacna)",
      "Restaurante La Plaza (Tacna)",
      "El Gran Hotel (Piura)",
      "Sushi House (Piura)",
      "Restaurante El Batan (Piura)",
      "Cevichería La Sirena (Piura)",
      "La Bodega de la Cerveza (Piura)",
      "Picantería La Chola (Piura)",
      "Restaurante La Casona (Piura)",
      "Café Puro (Piura)",
      "Cevichería Don Ceviche (Piura)",
      "Café de la Plaza (Piura)"
    ].sample
  end

  def returnProvince(province)
    if province.eql? 'Cusco'
      [
        "Cusco",
        "Calca",
        "Urubamba",
        "Canchis",
        "Anta"
      ].sample
    elsif province.eql? 'Piura'
      [
        "Piura",
        "Talara",
        "Sullana",
        "Paita",
        "Sechura",
        "Morropón",
        "Huancabamba",
        "Ayabaca"
      ].sample
    elsif province.eql? 'Tacna'
      [
        "Tacna",
        "Arica y Parinacota",
        "Camarones",
        "Tacna",
        "Cerro Blanco",
        "Tarata"
      ].sample
    else
      "Lima"
    end
  end

  def randomDirecciones(distrito)
    if distrito.eql? 'Lima'
      [
        "Avenida José Larco",
        "Avenida Arequipa",
        "Avenida Pardo",
        "Avenida Nicolás de Piérola",
        "Avenida Benavides"
      ].sample
    elsif distrito.eql? 'Piura'
      [
        "Avenida Sánchez Cerro",
        "Avenida Loreto",
        "Avenida Chulucanas",
        "Avenida Grau",
        "Avenida Guillermo E. Billinghurst"
      ].sample
    elsif distrito.eql? 'Tacna'
      [
        "Avenida San Martín",
        "Avenida Bolognesi",
        "Avenida Grau",
        "Avenida Dos de Mayo",
        "Avenida Libertad"
      ].sample
    else
      [
        "Avenida Sol",
        "Calle Procuradores",
        "Calle Carmen Alto",
        "Avenida El Sol",
        "Calle Espinar"
      ].sample
    end
  end

  def randomNumeracion
    [
      "980",
      "1098",
      "12",
      "873",
      "982",
      "330",
      "972",
    ].sample
  end

  def randomDistritos(distrito)
    if distrito.eql? 'Lima'
      [
        "Miraflores",
        "San Isidro",
        "Barranco",
        "Lima",
        "Surco",
        "San Borja",
        "San Miguel",
        "La Molina"
      ].sample
    elsif distrito.eql? 'Piura'
      [
        "Piura",
        "Sullana",
        "Paita",
        "Talara",
        "Morropón"
      ].sample
    elsif distrito.eql? 'Tacna'
      [
        "Tacna",
        "Cercado",
        "Pocollay",
        "Alto de la Alianza",
        "La Yarada-Los Palos"
      ].sample
    else
      [
        "Cusco",
        "San Sebastián",
        "San Jerónimo",
        "Santiago",
        "San Blas"
      ].sample
    end
  end


  def returnAddres(distrito)
    "#{randomDirecciones(distrito)} #{randomNumeracion}"
  end

  def valor_random_del_hash(hash)
    hash.values.sample
  end

  def returnMoment(moment)
    hoy = Date.today

    un_mes_futuro = hoy.next_month

    base_date = Date.new(2000, 1, 1)
    inicio_dias = (hoy - base_date).to_i
    fin_dias = (un_mes_futuro - base_date).to_i
    random_dias = rand(inicio_dias..fin_dias)
    fecha_aleatoria = base_date + random_dias

    if moment.eql? 'date'
      fecha_aleatoria
    else
      hora_inicio = 15
      hora_fin = 20
      hora_aleatoria = rand(hora_inicio..hora_fin)
      minuto_aleatorio = rand(0..59)
      fecha_hora_aleatoria = Time.new(fecha_aleatoria.year, fecha_aleatoria.month, fecha_aleatoria.day, hora_aleatoria, minuto_aleatorio, 0, "-05:00")
    end
  end


end
