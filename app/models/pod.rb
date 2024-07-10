# frozen_string_literal: true

class Pod < ApplicationRecord
  belongs_to :league
  has_many :pod_results, dependent: :destroy
  has_many :users, through: :pod_results

  validates :date, presence: true
end
