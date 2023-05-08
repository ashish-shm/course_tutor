# frozen_string_literal: true

class Course < ApplicationRecord
  CATEGORIES = %w[development gaming finance]

  has_many :tutors

  validates :category, inclusion: CATEGORIES
  validates :title, length: { in: 3..50 }
  validates :description, length: { in: 10..256 }

  accepts_nested_attributes_for :tutors
end
