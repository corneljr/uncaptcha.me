class HomeController < ApplicationController

  def intro
  	@user = User.new
  end

  def bitcoin_donation
  	@user = User.new
  	invoice = $client.post 'invoice', {:price => 10.00, :currency => 'USD'}
  	binding.pry
  	@url = invoice["url"].to_s + '&view=iframe'
  	render :intro
  end
end
