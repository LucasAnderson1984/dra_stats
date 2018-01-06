# frozen_string_literal: true

class DraScoreStudentsController < ApplicationController
  protected

  def dra_score_student_params
    return {} if params[:dra_score_student].nil?

    params
      .require(:dra_score_student)
      .permit(
        :dra_score_id,
        :score_date,
        :student_id
      )
  end
end
