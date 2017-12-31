# frozen_string_literal: true

class Teacher < ApplicationRecord
  validates \
    :first_name,
    :grade,
    :is_active,
    :last_name,
    :uuid,
    presence: true

  def name
    [last_name, first_name].compact
  end

  def long_name
    name.join(', ')
  end
end
