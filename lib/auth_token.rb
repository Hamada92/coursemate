class AuthToken
  SIGNATURE_ALGORITHM = 'HS256'.freeze

  attr_reader :token

  def initialize payload: {}, token: nil
    @payload = claims.merge(payload)
    @token = JWT.encode @payload, secret_key, SIGNATURE_ALGORITHM
  end
  
  def to_json options={}
    {jwt: token}.to_json
  end

  private
    def claims
      _claims = {}
      _claims[:exp] = token_lifetime
      _claims[:aud] = nil
      _claims
    end

    def token_lifetime
      #expire token after 1 day
      1.day.from_now.to_i
    end

    def secret_key
      Rails.application.secrets.secret_key_base
    end

end
