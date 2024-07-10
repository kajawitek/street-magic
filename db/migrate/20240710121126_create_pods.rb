# frozen_string_literal: true

class CreatePods < ActiveRecord::Migration[7.1]
  def change
    create_table :pods do |t|
      t.date :date, null: false
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
