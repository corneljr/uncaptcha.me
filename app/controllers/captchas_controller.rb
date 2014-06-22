

class CaptchasController < ApplicationController
	# before_filter :authenticate, except: [:status]

	def js
		 send_file 'public/.....', type: 'text/javascript'
	end

	def get
		@captcha = Captcha.gif()
		User.find_by(pub_key: params[:k]).captcha.new(sequence: @captcha[:sequence], image: @captcha[:gif], read: false)
		render :json => { id: @captcha.id, image: @captcha.image }, status: 200
	end

	def check
		requested_captcha = Captcha.find(params[:id])
		if Captcha.authenticate_public(params[:id]) && params[:s] == requested_captcha.sequence
			render json: { success: true }, status: 200
		else
			render json: { success: false }, status: 200
		end
	end

	def status
		requested_captcha = Captcha.find(params[:id])
		if Captcha.authenticate_private(params[:k]) && requested_captcha.read?
			render :json => { success: Captcha.find(params[:id]).success }, status: 200
		else
			render nothing: true, status: 420
		end
		requested_captcha.status = 'read'
	end

private

	def authenticate
		unless Captcha.authenticate_public(params[:k])
			render nothing: true, status: 420
		end
	end

end