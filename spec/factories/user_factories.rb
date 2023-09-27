FactoryBot.define do
  factory(:user) do
    after(:build)   { |user| user.skip_confirmation! }
    after(:create) { |user| Chat.create(sender_id: user.id) }
    email { Faker::Internet.email }
    password {'12345678'}
    password_confirmation {'12345678'}
  end

  factory :admin, class: User do
    after(:build)   { |user| user.skip_confirmation! }
    after(:create) { |user| user.add_role :admin }
    email { Faker::Internet.email }
    password {'12345678'}
    password_confirmation {'12345678'}
  end

  factory :staff, class: User do
    after(:build)   { |user| user.skip_confirmation! }
    after(:create) { |user| user.add_role :staff }
    email { Faker::Internet.email }
    password {'12345678'}
    password_confirmation {'12345678'}
  end
end
