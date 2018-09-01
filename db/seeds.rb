require 'faker'

(1..40).each do |record|
  Person.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, birthdate: Faker::Date.between(80.years.ago, 18.years.ago))
end

# I think this is a while loop. While record <= 40 do each of the Person.create methods. Right?
