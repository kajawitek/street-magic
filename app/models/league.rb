# frozen_string_literal: true

class League < ApplicationRecord
  has_many :pods, dependent: :destroy
  has_many :users, through: :pods

  validates :year, presence: true
end
