class UsersController < ApplicationController
	
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to edit_user(@user)
		else 
			render :new
		end
	end

	def new
		@user = User.new 
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
		params.require(:user).permit(:email, :password, :password_confirmation, :domains)
	end

end
