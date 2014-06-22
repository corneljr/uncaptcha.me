class UsersController < ApplicationController

	def create
		@user = User.new(user_params)
		@user.domains.new(domain_params)

		if @user.save
			redirect_to edit_user(@user)
		else
			@domain = Domain.new
			render :new
		end
	end

	def preferences
		@user = current_user
	end

	def edit
		@user = current_user
	end

	def update
		@user = User.update(user_params)
	end

private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def domain_params
		params.require(:domain).permit(:url)
	end

end
