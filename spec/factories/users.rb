# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{first_name.downcase}.#{last_name.downcase}@example.com" }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
  end
end
