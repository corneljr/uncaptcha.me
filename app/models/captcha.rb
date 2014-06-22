class Captcha < ActiveRecord::Base
	belongs_to :user

	def read?
		read_attribute(:read)
	end

	def self.gif
		$redis.publish $channel, 'h'
		JSON.parse($redis.lpop($list), :symbolize_keys => true)
	end

	def self.authenticate_public(key)
		@user = User.find_by(pub_key: key)
		@user && @user.domains.include?("requesting domain")
	end

	def self.authenticate_private(key)
		@user = User.find_by(pub_key: key)
		@user && @user.domains.include?("requesting domain")
	end
end
