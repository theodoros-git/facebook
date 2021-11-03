class User < ApplicationRecord

	has_many :publications
  	has_many :commentaires
	validates :nom, presence: true, length: { maximum: 30 }
	validates :prenom, presence: true, length: { maximum: 30 }
  	validates :email, presence: true, length: { maximum: 255 },
  						format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  	before_validation { email.downcase! }
  	#has_secure_password
  	validates :password, length: { minimum: 6 }
  	has_secure_password
end
