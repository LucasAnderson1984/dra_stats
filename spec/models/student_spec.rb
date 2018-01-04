# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  subject { build(:student) }

  it { is_expected.to belong_to :teacher }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :grade }
  it { is_expected.to validate_presence_of :is_active }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :student_id }
  it { is_expected.to validate_numericality_of :is_active }
  it { is_expected.to validate_numericality_of :student_id }
end
