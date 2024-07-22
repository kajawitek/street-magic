# frozen_string_literal: true

class Pod < ApplicationRecord
  belongs_to :league
  has_many :pod_results, dependent: :destroy
  has_many :users, through: :pod_results

  # TODO: date should be in the past or today
  # TODO: should have at least 3 users
  validates :date, presence: true

  accepts_nested_attributes_for :pod_results
end
