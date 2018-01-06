# frozen_string_literal: true

class DraScore < ApplicationRecord
  has_many :dra_score_students, dependent: :destroy
  has_many :students, through: :dra_score_students

  validates \
    :dra_level,
    :rank,
    presence: true,
    uniqueness: true

  validates \
    :rank,
    numericality: true
end
