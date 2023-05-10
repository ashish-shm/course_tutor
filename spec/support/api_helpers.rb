# frozen_string_literal: true

module ApiHelpers
  def headers(user, options = {})
    {
      "X-Auth-Token" => user.authentication_token,
      "X-Auth-Email" => user.email
    }.merge(options)
  end
end
