class ChargesController < ApplicationController
  require 'stripe'

def new
  if current_user.basic?
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: 'BigMoney Membership',
      amount: 500
    }
  elsif current_user.premium?
    current_user.basic!
    current_user.wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end
    redirect_to root_path
  else current_user.admin?
       redirect_to root_path
     end
   end


  def create
    # Amount in cents
    if current_user.basic?
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
    end
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
      end
end
