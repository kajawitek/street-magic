# frozen_string_literal: true

class CreateLeagues < ActiveRecord::Migration[7.1]
  def change
    create_table :leagues do |t|
      t.integer :year, null: false

      t.timestamps
    end
  end
end
