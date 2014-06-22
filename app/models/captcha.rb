class Captcha < ActiveRecord::Base

	def read?
		read_attribute(:read)
	end

	def self.gif
		$redis.publish $channel, 'h'
		JSON.parse($redis.lpop($list), :symbolize_keys => true)
	end

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
