task create_patient_data: :environment do
  5.times do
    Clinic.connection.patients.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    dob: Faker::Date.between(100.years.ago, 11.years.ago),
    description: Faker::Lorem.word,
      })
  end
end