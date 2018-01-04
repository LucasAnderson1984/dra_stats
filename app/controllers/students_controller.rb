# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    render_index
  end

  protected

  def render_index
    if params[:teacher_id]
      render json: resources.where(teacher_id: params[:teacher_id])
    else
      render json: resources
    end
  end

  def student_params
    return {} if params[:student].nil?

    params
      .require(:student)
      .permit(
        :date_of_birth,
        :first_name,
        :grade,
        :is_active,
        :last_name,
        :middle_name,
        :student_id,
        :teacher_id
      )
  end
end
