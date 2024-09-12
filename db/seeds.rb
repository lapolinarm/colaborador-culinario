require 'active_support/all'
puts "Borrando job_users..."
JobUser.destroy_all # Elimina todas las job_users existentes

puts "Borrando jobs..."
Job.destroy_all # Elimina todas las jobs existentes

puts "Borrando restaurants..."
Restaurant.destroy_all # Elimina todas los restaurants existentes

puts "Borrando usuarios..."
User.destroy_all # Elimina todos los usuarios existentes

puts "Reseteando PK ID..."
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('restaurants')
ActiveRecord::Base.connection.reset_pk_sequence!('jobs')
ActiveRecord::Base.connection.reset_pk_sequence!('job_users')
ActiveRecord::Base.connection.reset_pk_sequence!('favorites')

puts "=" * 50
puts "Inicio el Seeds en las tablas"

10.times do
  instance = Util.new

  typePayMethod = {
    "Efectivo" => 0,
    "Transferencia bancaria" => 1,
    "Monederos digitales" => 2
  }

  valPayMethod = instance.valor_random_del_hash(typePayMethod)

  user = User.create!(
    email: Faker::Internet.email,
    dni: rand(10000000..99999999),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    mobile_phone: "99#{rand(1000000..9999999).to_s}",
    role: Util::COLABORADOR,
    address: Faker::Address.full_address,
    payment_method: valPayMethod,
    bank: valPayMethod.eql?(1) ? ["BBVA", "BCP", "Interbank", "Banbif", "Scotiabank", "Other"].sample : "-",
    name_holder: Faker::Name.first_name,
    bank_account: valPayMethod.eql?(1) ? rand(1000000000..9999999999) : "-",
    cci: valPayMethod.eql?(1) ? rand(10000000000000000000..99999999999999999999) : "-",
    digital_wallet: valPayMethod.eql?(2) ? ["Yape", "Plin"].sample : "-",
    password: '123456'
  )

  valRestaurant = instance.returnRestaurants
  location = valRestaurant.to_s[-7..-1].strip[1..-2]

  # puts "Creando restaurantes aleatorios..."

  restaurant = Restaurant.create!(
    ruc: "201#{rand(10000000..99999999)}",
    commercial_name: valRestaurant[0...-7].strip,
    company_name: "#{valRestaurant[0...-7].strip.to_s.upcase} S.A.C",
    phone: "01#{rand(1000000..9999999)}",
    mobile_phone:"9#{rand(10000000..99999999).to_s}",
    address: instance.returnAddres(location),
    district: instance.randomDistritos(location),
    province: instance.returnProvince(location),
    country: 'Perú',
    reference: "XX_reference",
    user: user
  )

  typeJob = {
    "Fulltime" => 0,
    "Parttime" => 1
  }
  valTypeJob = instance.valor_random_del_hash(typeJob)

  typeJobMode = {
    "Presencial" => 0,
    "Remoto" => 1,
    "Hibrido" => 2
  }
  valTypeJobMode = instance.valor_random_del_hash(typeJobMode)

  typeFunction = {
    "Mozo" => 0,
    "Azafata" => 1,
    "Delivery" => 2,
    "Lavaplatos" => 3
  }

  valTypeFunction = instance.valor_random_del_hash(typeFunction)
  hourTemp = instance.returnStarTime #Hora
  random_hours_sum = rand(2..4) #es una hora aleatoria
  randomPaymentHour = [10, 20, 30, 40, 50].sample

  # puts "Creando Jobs aleatorios..."

  job = Job.create!(
    date: instance.returnDate,
    hour_start: hourTemp,
    hour_end: hourTemp + (random_hours_sum * 3600), #a la hora, se le suma
    payment_hour: randomPaymentHour,
    job_type: valTypeJob,
    job_mode: valTypeJobMode,
    function: valTypeFunction,
    description: instance.returnDescriptionJob(valTypeFunction),
    responsibility: instance.returnresponsibilityJob(valTypeFunction),
    requirement: instance.returnRequirementJob(valTypeFunction),
    restaurant: restaurant
  )

  typeStatus = {
    "aceptado" => 0,
    "pendiente" => 1,
    "rechazado" => 2
  }
  valtypeStatus = instance.valor_random_del_hash(typeStatus)

  # puts "Creando JobUsers aleatorios..."

  job_user = JobUser.create!(
    status: valtypeStatus,
    payment_method_used: valPayMethod,
    amount_paid: randomPaymentHour,
    user: user,
    job: job
  )

  # puts "Creando Favorites aleatorios..."

  favorite = Favorite.create!(
    user: user,
    job: job
  )

end
puts "terminando el Seeds"
puts "=" * 50
