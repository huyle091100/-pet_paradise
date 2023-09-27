FactoryBot.define do
  factory(:bill ) do
    order_id { Faker::Name.female_first_name }
    message {Faker::Movie.quote}
    amount { Faker::Commerce.price}
    user_id { create(:user).id}
  end
end