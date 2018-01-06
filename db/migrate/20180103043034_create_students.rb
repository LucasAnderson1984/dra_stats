# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students, id: :uuid do |t|
      t.references :teacher, type: :uuid, null: false
      t.integer :student_id_number, limit: 8, null: false
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.date :date_of_birth
      t.string :grade, null: false
      t.integer :is_active, default: 1, null: false

      t.timestamps
    end

    add_index :students, :student_id_number, unique: true
  end
end
