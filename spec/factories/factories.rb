FactoryGirl.define do 
  factory :clinic do 
    name 'clinic'
    address 'address'
    city 'city'
    state 'state'
    zip 12345
  end

  factory :patient do
     first_name 'name'
     last_name 'last name'
     dob 12.years.ago
     description 'sick'
     gender 'gender'
     blood_type 'blood type'
  end

  factory :doctor do 
    name 'name'
  end

  factory :drug do
    name 'name'
    description 'description'
    cost 2.0 
  end
end