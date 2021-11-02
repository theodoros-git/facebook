class UserController < ApplicationController

	def signup
		render "general/signup", layout: false
	end

	def signup_form
		@user = User.new(user_params)
	end

	private

		def user_params
			params.require(:user).permit(:nom, :prenom, :email, :gender, :date_of_birth, :password)
		end
end
