class PayController < ApplicationController
    
  def index
    #Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account/apikeys
    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    recurring = params[:recurring]
    
    if recurring
      begin
        customer = Stripe::Customer.create(
            :email => params[:email],
            :card => token
          )
        charge = Stripe::Charge.create(
            :amount => params[:amount], # amount in cents, again
            :currency => "usd",
            :customer => customer.id,
            :description => params[:name],
            :receipt_email => params[:email]
          )
      rescue Stripe::CardError => e
        # The card has been declined
        render :text =>'declined'.html_safe
      end
      render :text =>'accepted'.html_safe
    else
      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => params[:amount], # amount in cents, again
          :currency => "usd",
          :source => token,
          :description => params[:name],
          :receipt_email => params[:email]
        )
      rescue Stripe::CardError => e
        # The card has been declined
        render :text =>'declined'.html_safe
      end
      render :text =>'accepted'.html_safe
    end
    
    Mailer.thankyou_email(params[:name], params[:email]).deliver
    
  end

end
