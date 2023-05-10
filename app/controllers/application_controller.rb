# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable
  include Authorisable
  include ApiRescuable
end
