# frozen_string_literal: true

class DraScoresController < ApplicationController
  protected

  def dra_score_params
    return {} if params[:dra_score].nil?

    params
      .require(:dra_score)
      .permit(
        :dra_level,
        :rank
      )
  end
end
