class DonationsController < ApplicationController
  def index
    @publishable_key = Rails.configuration.stripe[:publishable_key]
  end
  
end
