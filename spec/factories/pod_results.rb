# frozen_string_literal: true

FactoryBot.define do
  factory :pod_result do
    pod
    user
    place { 1 }
    score { 1 }
  end
end
