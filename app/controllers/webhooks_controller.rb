class WebhooksController < ApplicationController

	def index
		`bash webook.sh`
		redirect_to root_path
	end
end
