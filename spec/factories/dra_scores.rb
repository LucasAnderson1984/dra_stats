# frozen_string_literal: true

FactoryBot.define do
  factory :dra_score do
    dra_level { Faker::Number.number(2) }
    rank { Faker::Number.number(2).to_s }
  end
end
