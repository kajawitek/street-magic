# frozen_string_literal: true

class RenamePointsToScoreInPodResults < ActiveRecord::Migration[7.1]
  def change
    rename_column :pod_results, :points, :score
  end
end
