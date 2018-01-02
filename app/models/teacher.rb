# frozen_string_literal: true

class Teacher < ApplicationRecord
  include ClassyEnum::ActiveRecord

  classy_enum_attr :grade

  validates \
    :first_name,
    :grade,
    :is_active,
    :last_name,
    presence: true

  validates :is_active, numericality: true

  def name
    [last_name, first_name].compact
  end

  def long_name
    name.join(', ')
  end
end
