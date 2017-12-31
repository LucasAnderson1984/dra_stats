# frozen_string_literal: true

class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.uuid :uuid, null: false
      t.string :first_name, limit: 30, null: false
      t.string :last_name, limit: 30, null: false
      t.string :grade, limit: 15, null: false
      t.integer :is_active, default: 1, null: false

      t.timestamps
    end
  end
end
