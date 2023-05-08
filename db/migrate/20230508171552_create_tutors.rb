# frozen_string_literal: true

class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.references :course, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
