require 'active_support/all'
require 'faker'

puts "Borrando job_users..."
JobUser.destroy_all
puts "Borrando jobs..."
Job.destroy_all
puts "Borrando restaurants..."
Restaurant.destroy_all
puts "Borrando usuarios..."
User.destroy_all

puts "Reseteando PK ID..."
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('restaurants')
ActiveRecord::Base.connection.reset_pk_sequence!('jobs')
ActiveRecord::Base.connection.reset_pk_sequence!('job_users')
ActiveRecord::Base.connection.reset_pk_sequence!('favorites')

puts "=" * 50
puts "Iniciando el seed en las tablas..."

# Usuarios específicos
users = [
  { email: "jaime@mail.com", first_name: "Jaime", last_name: "Obispo", role: "collaborator" },
  { email: "laura@mail.com", first_name: "Laura", last_name: "Ramírez", role: "collaborator" },
  { email: "levi@mail.com", first_name: "Levi", last_name: "Apolinar", role: "owner" },
  { email: "luis@mail.com", first_name: "Luis", last_name: "Roldán", role: "owner" }
]
instance = Util.new

typePayMethod = {
  "Efectivo" => 0,
  "Transferencia bancaria" => 1,
  "Monederos digitales" => 2
}

valPayMethod = instance.valor_random_del_hash(typePayMethod)

users.each do |user_attrs|
  User.create!(
    email: user_attrs[:email],
    first_name: user_attrs[:first_name],
    last_name: user_attrs[:last_name],
    role: user_attrs[:role],
    mobile_phone: "99#{rand(1000000..9999999)}",
    dni: rand(10000000..99999999),
    address: Faker::Address.full_address,
    payment_method: valPayMethod, # Método de pago aleatorio
    bank: valPayMethod.eql?(1) ? ["BBVA", "BCP", "Interbank", "Banbif", "Scotiabank", "Other"].sample : "-",
    name_holder: Faker::Name.first_name,
    bank_account: valPayMethod.eql?(1) ? rand(1000000000..9999999999) : "-",
    cci: valPayMethod.eql?(1) ? rand(10000000000000000000..99999999999999999999) : "-",
    digital_wallet: valPayMethod.eql?(2) ? ["Yape", "Plin"].sample : "-",
    password: '123456'
  )
end

# Usuarios adicionales (colaboradores y owners)
20.times do
  User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: ["owner", "collaborator"].sample,
    mobile_phone: "99#{rand(1000000..9999999)}",
    dni: rand(10000000..99999999),
    address: Faker::Address.full_address,
    payment_method: valPayMethod,
    bank: valPayMethod.eql?(1) ? ["BBVA", "BCP", "Interbank", "Banbif", "Scotiabank", "Other"].sample : "-",
    name_holder: Faker::Name.first_name,
    bank_account: valPayMethod.eql?(1) ? rand(1000000000..9999999999) : "-",
    cci: valPayMethod.eql?(1) ? rand(10000000000000000000..99999999999999999999) : "-",
    digital_wallet: valPayMethod.eql?(2) ? ["Yape", "Plin"].sample : "-",
    password: '123456'
  )
end

# Crear restaurantes para los owners
owners = User.where(role: 'owner')
valRestaurant = instance.returnRestaurants
location = valRestaurant.to_s[-7..-1].strip[1..-2]

owners.each do |owner|
  5.times do
    Restaurant.create!(
      ruc: "201#{rand(10000000..99999999)}",
      commercial_name: valRestaurant[0...-7].strip,
      company_name: "#{valRestaurant[0...-7].strip.to_s.upcase} S.A.C",
      phone: "01#{rand(1000000..9999999)}",
      mobile_phone: "9#{rand(10000000..99999999)}",
      address: instance.returnAddres(location),
      district: instance.randomDistritos(location),
      province: instance.returnProvince(location),
      country: 'PE',  # Código de Perú
      reference: ["a 2 cuadras del ovalo", "cerca del mall Mágico", "pasando el aeropuerto", "pasando cine planet"].sample,
      user: owner
    )
  end
end

typeJob = {
  "Fulltime" => 0,
  "Parttime" => 1
}
valTypeJob = instance.valor_random_del_hash(typeJob)

typeJobMode = {
  "Presencial" => 0,
  "Hibrido" => 1
}
valTypeJobMode = instance.valor_random_del_hash(typeJobMode)

typeFunction = {
  "Mozo" => 0,
  "Azafata" => 1,
  "Delivery" => 2,
  "Lavaplatos" => 3
}

valTypeFunction = instance.valor_random_del_hash(typeFunction)
random_hours_sum = rand(2..4) #es una hora aleatoria
randomPaymentHour = [10, 20, 30, 40, 50].sample


typeStatus = {
  "aceptado" => 0,
  "pendiente" => 1,
  "rechazado" => 2
}
valtypeStatus = instance.valor_random_del_hash(typeStatus)

# Crear trabajos para los colaboradores
collaborators = User.where(role: 'collaborator')

collaborators.each do |collaborator|
  Restaurant.all.sample(3).each do |restaurant|
    10.times do
      # Crear trabajos con fechas, algunos expirados
      date = rand(1..10) > 2 ? Faker::Date.between(from: Date.today, to: 2.months.from_now) : Faker::Date.between(from: 2.months.ago, to: Date.today)
      job = Job.create!(
        date: date,
        hour_start: Time.now.beginning_of_day + rand(8..11).hours,
        hour_end: Time.now.beginning_of_day + rand(12..16).hours,
        payment_hour: randomPaymentHour,
        job_type: valTypeJob,
        job_mode: valTypeJobMode,
        function: valTypeFunction,
        description: instance.returnDescriptionJob(valTypeFunction),
        responsibility: instance.returnresponsibilityJob(valTypeFunction),
        requirement: instance.returnRequirementJob(valTypeFunction),
        restaurant: restaurant
      )

      # Crear relación entre el colaborador y el trabajo (JobUser)
      JobUser.create!(
        status: valtypeStatus,
        payment_method_used: valPayMethod,
        amount_paid: job.payment_hour,
        user: collaborator,
        job: job
      )
    end
  end
end

puts "Seeds finalizados exitosamente."
puts "=" * 50
