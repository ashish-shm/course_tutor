# frozen_string_literal: true

class Tutor < ApplicationRecord
  belongs_to :course

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
end
