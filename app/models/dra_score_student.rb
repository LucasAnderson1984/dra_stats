# frozen_string_literal: true

class DraScoreStudent < ApplicationRecord
  belongs_to :dra_score
  belongs_to :student

  validates \
    :dra_score_id,
    :score_date,
    :student_id,
    presence: true
end
