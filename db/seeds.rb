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

users.each do |user_attrs|
  User.create!(
    email: user_attrs[:email],
    first_name: user_attrs[:first_name],
    last_name: user_attrs[:last_name],
    password: '123456',
    role: user_attrs[:role],
    mobile_phone: "99#{rand(1000000..9999999)}",
    dni: rand(10000000..99999999),
    address: Faker::Address.full_address,
    payment_method: rand(0..2),  # Método de pago aleatorio
    bank: ["BBVA", "BCP", "Interbank"].sample,
    name_holder: Faker::Name.first_name,
    bank_account: rand(1000000000..9999999999),
    cci: rand(10000000000000000000..99999999999999999999),
    digital_wallet: ["Yape", "Plin"].sample
  )
end

# Usuarios adicionales (colaboradores y owners)
10.times do
  User.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: '123456',
    role: ["owner", "collaborator"].sample,
    mobile_phone: "99#{rand(1000000..9999999)}",
    dni: rand(10000000..99999999),
    address: Faker::Address.full_address,
    payment_method: rand(0..2),
    bank: ["BBVA", "BCP", "Interbank"].sample,
    name_holder: Faker::Name.first_name,
    bank_account: rand(1000000000..9999999999),
    cci: rand(10000000000000000000..99999999999999999999),
    digital_wallet: ["Yape", "Plin"].sample
  )
end

# Crear restaurantes para los owners
owners = User.where(role: 'owner')

owners.each do |owner|
  5.times do
    Restaurant.create!(
      ruc: "201#{rand(10000000..99999999)}",
      commercial_name: Faker::Restaurant.name,
      company_name: "#{Faker::Company.name} S.A.C.",
      phone: "01#{rand(1000000..9999999)}",
      mobile_phone: "9#{rand(10000000..99999999)}",
      address: Faker::Address.full_address,
      district: Faker::Address.community,
      province: Faker::Address.state,
      country: 'PE',  # Código de Perú
      reference: Faker::Address.secondary_address,
      user: owner
    )
  end
end

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
        payment_hour: [20, 30, 40, 50].sample,
        job_type: rand(0..1),
        job_mode: rand(0..1),
        function: rand(0..3),
        description: Faker::Job.field,
        responsibility: Faker::Job.key_skill,
        requirement: Faker::Job.education_level,
        restaurant: restaurant
      )

      # Crear relación entre el colaborador y el trabajo (JobUser)
      JobUser.create!(
        status: rand(0..2),
        payment_method_used: rand(0..2),
        amount_paid: job.payment_hour,
        user: collaborator,
        job: job
      )
    end
  end
end

puts "Seeds finalizados exitosamente."
puts "=" * 50
