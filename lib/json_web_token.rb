require 'jwt'

class JsonWebToken
  class << self
    def encode(payload, expiry=1.hour.from_now)
      payload[:expiry] = expiry.to_i
      secret_key_base = Rails.application.credentials.secret_key_base
      JWT.encode(payload, secret_key_base)
    end

    def decode(token)
      secret_key_base = Rails.application.credentials.secret_key_base
      body = JWT.decode(token, secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
