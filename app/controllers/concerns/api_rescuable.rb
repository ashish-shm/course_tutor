# frozen_string_literal: true

module ApiRescuable
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :handle_api_error
  end

  private

    def handle_api_error(exception)
      log_exception(exception)
      render status: 500, json: { error: "Something went wrong" }
    end

    def log_exception(exception)
      Rails.logger.info exception.class.to_s
      Rails.logger.info exception.to_s
      Rails.logger.info exception.backtrace.join("\n")
    end
end
