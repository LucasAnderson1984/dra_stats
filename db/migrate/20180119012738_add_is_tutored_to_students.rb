# frozen_string_literal: true

class AddIsTutoredToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :is_tutored, :integer, default: 0, null: false
  end
end
