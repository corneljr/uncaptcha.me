require 'securerandom'

class User < ActiveRecord::Base
	after_initialize :set_keys
	has_secure_password

	has_many :domains

	# validates :name, presence: true
	validates :password, length: { minimum: 6 }, confirmation: false
	validates :email, uniqueness: { case_sensitive: false }

	private

	def set_keys
		@password_confirmation = @password
		@uuid = SecureRandom.uuid.gsub('-','').chars.shuffle.join
		self.priv_key = @uuid[0..15]
		self.pub_key = @uuid[16..32]
	end
end
