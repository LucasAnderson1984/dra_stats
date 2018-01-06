# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DraScoreStudent, type: :model do
  it { is_expected.to belong_to :dra_score }
  it { is_expected.to belong_to :student }
  it { is_expected.to validate_presence_of :dra_score_id }
  it { is_expected.to validate_presence_of :score_date }
  it { is_expected.to validate_presence_of :student_id }
end
