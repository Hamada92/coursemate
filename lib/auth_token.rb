class AuthToken
  SIGNATURE_ALGORITHM = 'HS256'.freeze

  attr_reader :token

  def encode payload: {}
    @payload = claims.merge(payload)
    @token = JWT.encode @payload, secret_key, SIGNATURE_ALGORITHM
  end

  def find_user_from_token(token)
    begin
      decode token
      User.find @payload['sub']
    #rescue because we want to return head :unauthorized if the token is invalid
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end
  end

  def decode token
    @payload, _ = JWT.decode token.to_s, secret_key, true,  { algorithm: SIGNATURE_ALGORITHM }
    @token = token
  end

  private
    def claims
      _claims = {}
      _claims[:exp] = token_lifetime
      _claims[:aud] = nil
      _claims
    end

    def token_lifetime
      #expire token after 3 days
      3.day.from_now.to_i
    end

    def secret_key
      Rails.application.secrets.secret_key_base
    end

end
