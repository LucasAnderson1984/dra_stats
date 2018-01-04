# frozen_string_literal: true

class DraScore < ApplicationRecord
  validates \
    :dra_level,
    :rank,
    presence: true,
    uniqueness: true

  validates \
    :rank,
    numericality: true
end
