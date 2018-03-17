class SubscriptionsController < ApplicationController

  def unsubscribe
    verifier = ActiveSupport::MessageVerifier.new(Rails.application.secrets.secret_key_base)
    begin
      id = verifier.verify(params[:id])
      User.find(id).update_column(:subscribed, false)
      render plain: "Unsubscribed successfully"
    rescue ActiveSupport::MessageVerifier::InvalidSignature => e
      Raven.capture_exception(e)
      render plain: "Subscription not found", status: :bad_request
    end
  end
end
