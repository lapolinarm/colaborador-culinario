
require 'faker'

Restaurant.destroy_all
Job.destroy_all


10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "password"
  )
end

10.times do
  Restaurant.create!(
    ruc: Faker::Number.number(digits: 11),
    commercial_name: Faker::Restaurant.name,
    company_name: Faker::Company.name,
    phone: Faker::PhoneNumber.phone_number,
    mobile_phone: Faker::PhoneNumber.cell_phone,
    address: Faker::Address.street_address,
    district: Faker::Address.community,
    province: "Lima",
    country: "Perú",
    reference: Faker::Address.secondary_address,
    user_id: User.all.sample.id
  )
end


10.times do
  Job.create(
    date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    hour_start: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    hour_end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    payment_hour: Faker::Commerce.price(range: 10..50.0, as_string: true),
    job_type: Faker::Number.between(from: 1, to: 5), # Ajusta el rango según los tipos de trabajo que tengas
    job_mode: Faker::Number.between(from: 1, to: 3), # Ajusta el rango según los modos de trabajo que tengas
    function: Faker::Number.between(from: 1, to: 5), # Ajusta el rango según las funciones que tengas
    description: Faker::Lorem.paragraph,
    responsibility: Faker::Lorem.paragraph,
    requirement: Faker::Lorem.paragraph,
    restaurant_id: Restaurant.pluck(:id).sample # Asegúrate de que Restaurant tenga datos en la base de datos
  )
end
