class CaptchasController < ApplicationController
	# before_filter :authenticate, except: [:status]

	def js
		send_file 'public/.....', type: 'text/javascript'
	end

	def get
		@c = Captcha.gif()
		@user = User.find_by(pub_key: params[:k])
		@captcha = @user.captchas.create(sequence: @c["sequence"], image: @c["gif"], read: false)
		render :json => @captcha, only: [:id, :image], status: 200
	end

	def check
		@host = request.env['HTTP_HOST']
		@captcha = Captcha.find(params[:id])
		if Captcha.authenticate_public(params[:k], @host) && @captcha.check(params[:s])
			@captcha.update(success: true)
			render json: { success: true }, status: 200
		else
			@captcha.update(success: false)
			render json: { success: false }, status: 200
		end
	end

	def status
		@host = request.env['HTTP_HOST']
		@captcha = Captcha.find(params[:id])
		if Captcha.authenticate_private(params[:k], @host) && @captcha.read?
			render :json => { success: Captcha.find(params[:id]).success }, status: 200
		else
			render nothing: true, status: 420
		end
		@captcha.update(read: true)
	end

private

	def authenticate
		@host = request.env['HTTP_HOST']
		unless Captcha.authenticate_public(params[:k], @host)
			render nothing: true, status: 420
		end
	end

end