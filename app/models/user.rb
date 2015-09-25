require 'bcrypt'

class User
	include DataMapper::Resource

	attr_reader   :password
	attr_accessor :password_confirmation

	property :id, Serial
	property :email, String, required: true, unique: true
	property :password_digest, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	validates_presence_of :email
	validates_uniqueness_of :email
	validates_confirmation_of :password

	def self.authenticate(test_email, test_password)
		user = first(email: test_email)
		return unless user
		match = (BCrypt::Password.new(user.password_digest) == test_password)
		match ? user : nil
	end

end
