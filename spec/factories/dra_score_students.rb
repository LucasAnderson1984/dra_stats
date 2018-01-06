# frozen_string_literal: true

FactoryBot.define do
  factory :dra_score_student do
    association :dra_score, factory: :dra_score
    association :student, factory: :student
    score_date { Faker::Date.forward(31) }
  end
end
