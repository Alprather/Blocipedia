class ChargesController < ApplicationController
  require "stripe"

  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: 'BigMoney Membership',
      amount: 500
    }
  end

  def create
    # Amount in cents

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 500,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
    current_user.premium!
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
      end
end
