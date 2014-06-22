class Captcha < ActiveRecord::Base

	def self.authenticate_public(key)
		@user = User.find_by(pub_key: key)
		unless @user && @user.domains.include?("requesting domain")
			raise NotAuthorizedError
		end
	end

	def self.authenticate_private(key)
		@user = User.find_by(pub_key: key)
		unless @user && @user.domains.include?("requesting domain")
			raise NotAuthorizedError
		end
	end
end
