# frozen_string_literal: true

class Teacher < ApplicationRecord
  include ClassyEnum::ActiveRecord

  has_many :students, dependent: :destroy

  classy_enum_attr :grade

  validates \
    :first_name,
    :grade,
    :is_active,
    :last_name,
    presence: true

  validates :is_active, numericality: true

  def long_name
    [last_name, first_name].compact.join(', ')
  end

  def student_count
    students.length
  end
end
