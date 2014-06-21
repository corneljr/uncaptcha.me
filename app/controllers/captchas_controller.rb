

class CaptchasController < ApplicationController
	before_filter :authenticate

	def js_request
		begin
		  authenticate_public(params[:k])
		rescue 
			render nothing: true, status: 420
		end
			send_file 'public/.....', type: 'text/javascript'
	end

	def gif_request
		begin
		  authenticate_public(params[:k])
		  @captcha = JSON.parse(LPOP captcha, :symbolize_keys => true)
			User.find_by(pub_key: params[:k]).captcha.new(sequence: @captcha[:sequence], image: @captcha[:image], read: false)
			render :json => { id: @captcha.id, image: @captcha.image }
		rescue
			render nothing: true, status: 420
		end
	end

	def response_request
		begin 
			authenticate_public(params[:k])
			requested_captcha = Captcha.find(params[:id])
			if params[:sequence] == requested_captcha.sequence
				render :json => { success: true }
			else 
				render :json => { success: false }
			end
		rescue
			render nothing: true, status: 420
		end
	end

	def status_request
		begin
			authenticate_private(params[:k])
			if Captcha.find(params[:id]).read
				render nothing: true, status: 420
			else
				render :json => { state: params[:captcha].success }
			end
		rescue
			render nothing: true, status: 420
		end
		requested_captcha.status = 'read'
	end

	private

	def authenticate_public(key)
		@user = User.find_by(pub_key: key)
		unless @user && @user.domains.include?("requesting domain")
			raise NotAuthorizedError
		end
	end

	def authenticate_private(key)
		@user = User.find_by(priv_key: key)
		if @user
			if @user.domains.include?("requesting domain")
				true
			else 
				false
			end
		else
			false
		end
	end

end

end