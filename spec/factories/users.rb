FactoryBot.define do
  factory :user do
    username { "user_#{rand(999)}"}

    sequence(:email) { |e| "user_#{e}@example.com" }

    after(:build) { |u| u.password_confirmation = u.password = "123456" }

    color {"#000555"}

    association :questions
  end
end