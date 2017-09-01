class SubscriptionsController < ApplicationController

  def unsubscribe
    verifier = ActiveSupport::MessageVerifier.new(ENV['secret_key_base'])
    begin
      id = verifier.verify(params[:id])
      User.find(id).update_column(:subscribed, false)
      flash[:notice] = 'You are now unsubscribed'
      redirect_to root_path
    rescue ActiveSupport::MessageVerifier::InvalidSignature => e
      Raven.capture_exception(e)
      render plain: "Subscription not found", status: :bad_request
    end
  end
end