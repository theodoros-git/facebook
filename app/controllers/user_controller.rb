class UserController < ApplicationController

	def signup
		render "general/signup", layout: false
	end
	## Inscription
	def signup_form
		@user = User.new(user_params)
		if @user.save
			flash[:register_success] = "Vous vous êtes inscrit avec succès. Veuillez donc vous connecter. Merci"
			redirect_to '/'
		else
			flash[:register_errors] = @user.errors.full_messages
			redirect_to '/users/sign_up'
		end
	end
	## Connection
	def login
		@user = User.find_by(email:login_params[:email])
		if @user && @user.authenticate(login_params[:password])
			flash[:login_success] = "Connection réussie"
			session[:current_user_id] = @user.id
      		redirect_to '/users/dashboard'
	    else
	        flash[:login_errors] = "Identifiants incorrects"
	        redirect_to '/'
	    end
	end
	
	## fonction privée
	private

		def user_params
			params.require(:user).permit(:nom, :prenom, :email, :gender, :date_of_birth, :password)
		end

		def login_params
	        params.require(:login).permit(:email, :password )
	    end
end
