# frozen_string_literal: true

class CreateDraScoreStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :dra_score_students, id: :uuid do |t|
      t.references :dra_score, type: :uuid, null: false
      t.references :student, type: :uuid, null: false
      t.date :score_date, null: false

      t.timestamps
    end

    add_index :dra_score_students,
              %i(dra_score_id score_date student_id),
              name: 'dra_score_students_index',
              unique: false
  end
end
