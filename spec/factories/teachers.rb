# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    first_name { Faker::Name.first_name }
    grade { Grade.all.sample }
    is_active { 1 }
    last_name { Faker::Name.last_name }
  end
end
