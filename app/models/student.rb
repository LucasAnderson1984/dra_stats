# frozen_string_literal: true

class Student < ApplicationRecord
  include ClassyEnum::ActiveRecord

  belongs_to :teacher
  has_many :dra_score_students, dependent: :destroy
  has_many :dra_scores, through: :dra_score_students

  classy_enum_attr :grade

  validates \
    :first_name,
    :grade,
    :is_active,
    :is_tutored,
    :last_name,
    :student_id_number,
    :teacher,
    presence: true

  validates \
    :is_active,
    :is_tutored,
    :student_id_number,
    numericality: true

  def full_name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def long_name
    [last_name, first_name].compact.join(', ')
  end
end
