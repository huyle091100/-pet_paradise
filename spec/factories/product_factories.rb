FactoryBot.define do
  factory(:product ) do
    name { Faker::Name.female_first_name }
    description {Faker::Movie.quote}
    quantity {Faker::Number.between(from: 2, to: 10)}
    price { Faker::Commerce.price}
    category { Faker::Number.between(from: 2, to: 4) }
  end
end