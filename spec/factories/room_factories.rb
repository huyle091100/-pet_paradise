FactoryBot.define do
  factory(:room ) do
    r_type { Faker::Number.between(from: 0, to: 2) }
    weight {Faker::Number.between(from: 0, to: 4)}
    quantity {Faker::Number.between(from: 2, to: 10)}
    price { Faker::Commerce.price}
  end
end