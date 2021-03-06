# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  subject { build(:teacher) }

  it { is_expected.to have_many :students }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :grade }
  it { is_expected.to validate_presence_of :is_active }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_numericality_of :is_active }
end
