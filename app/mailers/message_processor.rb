module MessageProcessor
  def mail(header = {}, &block)
    message = super
    user = User.find_by(email: message.to.first)
    verifier = ActiveSupport::MessageVerifier.new(ENV['secret_key_base'])
    token = verifier.generate(user.id)
    parts = message.parts.any? ? message.parts : [message]

    parts.each do |part|
      if part.content_type.match(/text\/(html|plain)/)
        part.body = part.body.decoded.gsub(/%7B%7BSECRET_TOKEN%7D%7D/, CGI.escape(token))
      end
    end

    message
  end

end