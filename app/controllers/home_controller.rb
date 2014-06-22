class HomeController < ApplicationController
  def intro
  	@user = User.new
  end
end
