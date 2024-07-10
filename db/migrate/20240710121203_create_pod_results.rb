# frozen_string_literal: true

class CreatePodResults < ActiveRecord::Migration[7.1]
  def change
    create_table :pod_results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pod, null: false, foreign_key: true
      t.integer :place, null: false
      t.integer :points, null: false

      t.timestamps
    end
  end
end
