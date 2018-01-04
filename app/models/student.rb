# frozen_string_literal: true

class Student < ApplicationRecord
  include ClassyEnum::ActiveRecord

  belongs_to :teacher

  classy_enum_attr :grade

  validates \
    :first_name,
    :grade,
    :is_active,
    :last_name,
    :student_id,
    :teacher,
    presence: true

  validates \
    :is_active,
    :student_id,
    numericality: true

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def long_name
    [last_name, first_name].compact.join(', ')
  end
end
