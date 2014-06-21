class DomainsController < ApplicationController

	def create
		@domain = Domain.new(domain_params)
		if @domain.save
			redirect_to user(current_user)
		else 
			redirect_to edit_user(current_user)
		end
	end

	def new
		@domain = Domain.new
	end

	private

	def domain_params
		params.require(:domain).permit(:url, :user_id)
	end
end
