# frozen_string_literal: true

class CreateDraScores < ActiveRecord::Migration[5.1]
  def change
    create_table :dra_scores, id: :uuid do |t|
      t.integer :rank
      t.string :dra_level
    end

    add_index :dra_scores, :rank, unique: true
    add_index :dra_scores, :dra_level, unique: true
  end
end
