# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum role: { "standard": 0, "admin": 1 }
  validates :email, uniqueness: true
  validates :password_confirmation, presence: true, on: :create
  validates :first_name, :last_name, :email, presence: true

  before_save :ensure_authentication_token_is_present

  private

    def ensure_authentication_token_is_present
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
