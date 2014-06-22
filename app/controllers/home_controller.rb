class HomeController < ApplicationController

  def intro
  	@user = User.new
    invoice = $client.post 'invoice', {:price => 10.00, :currency => 'USD'}
    @url = invoice["url"].to_s + '&view=iframe'
    @sample = User.find_by(email: 'zack@uncaptcha.me')
  end

end
