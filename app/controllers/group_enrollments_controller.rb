class GroupEnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_group, only: [:create]

  def create
    if !current_user.in_group?(@group.id) && !@group.is_full?
      @amount = @group.admission_fee * 100

      # Get the payment token submitted by the form:
      stripe_token = params[:stripeToken]

      # Charge the user's card:
      charge = Stripe::Charge.create(
        :amount => @amount,
        :currency => "cad",
        :description => "payment for group  #{@group.id}",
        :source => stripe_token,
      )

      GroupEnrollment.create(user_id: current_user.id, group_id: @group.id)

      respond_to do |format|
        format.html { redirect_to @group}
      end

    else
      head :no_content
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @group

  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

end
