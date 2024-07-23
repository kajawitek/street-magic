# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    year { Time.zone.today.year }
  end
end
