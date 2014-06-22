class ApplicationController < ActionController::Base

private

	def current_user
		cookies.signed[:user_id] ? User.find(cookies.signed[:user_id]) : nil
	end

  helper_method :current_user
end
 
