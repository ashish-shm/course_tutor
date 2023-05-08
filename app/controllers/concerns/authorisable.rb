# frozen_string_literal: true

module Authorisable
  extend ActiveSupport::Concern

  included do
    before_action :ensure_current_user_is_admin, only: :create
  end

  private

    def ensure_current_user_is_admin
      render status: :forbidden, json: { error: "Access Denied" } unless current_user.admin?
    end
end
