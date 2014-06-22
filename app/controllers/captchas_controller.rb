

class CaptchasController < ApplicationController
	before_filter :authenticate

	def js
		begin
		  Captcha.authenticate_public(params[:k])
		  send_file 'public/.....', type: 'text/javascript'
		rescue 
			render nothing: true, status: 420
		end
	end

	def get
		begin
		  Captcha.authenticate_public(params[:k])
		  @captcha = JSON.parse(:sequence => LPOP gifs, :symbolize_keys => true)
			User.find_by(pub_key: params[:k]).captcha.new(sequence: @captcha[:sequence], image: @captcha[:image], read: false)
			render :json => { id: @captcha.id, image: @captcha.image }, status: 200
		rescue
			render nothing: true, status: 420
		end
	end

	def check
		begin 
			Captcha.authenticate_public(params[:k])
			requested_captcha = Captcha.find(params[:id])
			if params[:s] == requested_captcha.sequence
				render :json => { success: true }, status: 200
			else 
				render :json => { success: false }, status: 200
			end
		rescue
			render nothing: true, status: 420
		end
	end

	def status
		begin
			Captcha.authenticate_private(params[:k])
			if Captcha.find(params[:id]).read
				render nothing: true, status: 420
			else
				render :json => { success: Captcha.find(params[:id]).success }, status: 200
			end
		rescue
			render nothing: true, status: 420
		end
		requested_captcha.status = 'read'
	end

end