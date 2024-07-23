# frozen_string_literal: true

class Pod < ApplicationRecord
  belongs_to :league
  has_many :pod_results, dependent: :destroy
  has_many :users, through: :pod_results

  validates :date, presence: true, comparison: { less_than_or_equal_to: -> { Time.zone.today } }
  validates :pod_results, length: { minimum: 3 }

  accepts_nested_attributes_for :pod_results
end
