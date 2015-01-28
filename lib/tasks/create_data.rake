task create_data: :environment do
  new_patient = Patient.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Faker::Date.between(100.years.ago, 11.years.ago),
    description: Faker::Lorem.word,

  })
  1.times do
    Clinic.create!({
      name: Faker::Company.name,
      address: Faker::Address.street_name,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip_code,
      patients: [
        new_patient
      ]

    })
  end
end