class CaptchaController < ApplicationController
	before_filter :authenticate, only: [:js, :get, :check, :status]

	def js
		@javascript = Twiggler::Application.assets.find_asset('captcha.js').body
		@javascript = @javascript.
										gsub(/DOMAIN/, request.protocol + request.host_with_port).
										gsub(/PUB_KEY/, params[:k])
		render(js: @javascript)
	end

	def css
		@stylesheet = Twiggler::Application.assets.find_asset('captcha.css').body
	  render(body: @stylesheet, content_type: 'text/css')
	end

	def get
		@c = Captcha.gif()
		@user = User.find_by(pub_key: params[:k])
		@captcha = @user.captchas.new(sequence: @c["sequence"], image: @c["gif"], read: false)
		if @captcha.save
			render(json: @captcha, only: [:id, :image], status: 200)
		else
			render(nothing: true, status: 500)
		end
	end

	def check
		@captcha = Captcha.find(params[:id])
		if @captcha.check(params[:s])
			@captcha.update(success: true)
			render(json: { success: true }, status: 200)
		else
			@captcha.update(success: false)
			render(json: { success: false }, status: 200)
		end
	end

	def status
		@captcha = Captcha.find(params[:id])
		if Captcha.authenticate_private(params[:k], request.env['HTTP_HOST']) && @captcha.read?
			render(:json => { success: @captcha.status }, status: 200)
		else
			render(nothing: true, status: 420)
		end
		@captcha.update(read: true)
	end

private

	def authenticate
		unless Captcha.authenticate_public(params[:k], request.env['HTTP_HOST'])
			render(nothing: true, status: 420)
		end
	end

end