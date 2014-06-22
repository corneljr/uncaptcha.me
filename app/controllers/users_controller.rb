class UsersController < ApplicationController

	def create
		if @user = User.find_by(email: user_params[:email])
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
		@user = current_user
		@domains = Domain.where(user_id: @user.id)
	end

	def update
		user_params = params.require(:user).permit(:email, :password, :domains)
		domains = user_params[:domains].split(",").map(&:strip)
		unless user_params[:password].empty?
			current_user.password = user_params[:password]
			current_user.save
		end
		current_user.update(email: user_params[:email])
		redirect_to preferences_path
	end

private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
