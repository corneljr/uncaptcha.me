class UsersController < ApplicationController

	def create
		@user = User.find_by(email: user_params[:email])
		if @user
			if @user.try(:authenticate, user_params[:password])
				cookies.signed[:user_id] = @user.id
				redirect_to preferences_path
			else
				redirect_to root_path
			end
		else
			@user = User.new(user_params)
			if @user.save
				redirect_to preferences_path
			else
				redirect_to root_path
			end
		end
	end

	def preferences
	end

private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
