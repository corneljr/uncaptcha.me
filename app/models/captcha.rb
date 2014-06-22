class Captcha < ActiveRecord::Base
	belongs_to :user

	def check(sequence)
		self.sequence == sequence
	end

	def status
		read_attribute(:success)
	end

	def read?
		read_attribute(:read)
	end

	def self.gif
		$redis.publish $channel, 'h'
		JSON.parse($redis.lpop($list), :symbolize_keys => true)
	end

	def self.authenticate_public(key, url)
		@user = User.find_by(pub_key: key)
		@user && @user.domains.find_by!(url: url.split(":").first)
	end

	def self.authenticate_private(key, url)
		@user = User.find_by(pub_key: key)
		@user && @user.domains.find_by!(url: url.split(":").first)
	end
end
