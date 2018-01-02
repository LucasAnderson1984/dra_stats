# frozen_string_literal: true

class TeachersController < ApplicationController
  protected

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
