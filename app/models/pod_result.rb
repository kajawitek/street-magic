# frozen_string_literal: true

class PodResult < ApplicationRecord
  belongs_to :user
  belongs_to :pod

  validates :place, :score, presence: true
end
