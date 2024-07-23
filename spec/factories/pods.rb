# frozen_string_literal: true

FactoryBot.define do
  factory :pod do
    date { Faker::Date.between(from: 1.year.ago, to: Time.zone.today) }
    league

    after(:build) do |pod, _evaluator|
      pod.pod_results << FactoryBot.build_list(:pod_result, 3, pod:)
    end
  end
end
