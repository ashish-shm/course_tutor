# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
