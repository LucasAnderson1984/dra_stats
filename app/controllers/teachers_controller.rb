# frozen_string_literal: true

class TeachersController < ApplicationController
  protected

  def render_index
    teachers = resources.map do |teacher|
      teacher.attributes.merge(student_count: teacher.student_count)
    end

    render json: teachers
  end

  def teacher_params
    return {} if params[:teacher].nil?

    params
      .require(:teacher)
      .permit(
        :first_name,
        :grade,
        :is_active,
        :last_name
      )
  end
end
