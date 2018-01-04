# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DraScore, type: :model do
  it { is_expected.to validate_presence_of :dra_level }
  it { is_expected.to validate_presence_of :rank }
  it { is_expected.to validate_uniqueness_of :dra_level }
  it { is_expected.to validate_uniqueness_of :rank }
  it { is_expected.to validate_numericality_of :rank }
end
