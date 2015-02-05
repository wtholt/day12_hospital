task create_drug: :environment do 
  50.times do 
    Drug.create!({
      name: Faker::Company.name,
      description: Faker::Company.catch_phrase,
      cost: Faker::Number.number(2)

    })
  end
end