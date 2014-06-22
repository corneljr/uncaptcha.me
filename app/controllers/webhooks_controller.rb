class WebhooksController < ApplicationController

	def index
		if request.remote_ip == '192.30.252.129'
			system 'git pull'
		end
	end
end
