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

	def new
		@user = User.new 
		@domain = Domain.new
	end

	def show
		@user = User.find(params[:id])
	end

	def index
	end

	def update
		@user = User.update(user_params)
	end

	def edit
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def domain_params
		params.require(:domain).permit(:url)
	end

end
