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
	## dashboard
	def dashboard
		@publications = Publication.all
		@users = User.all
		@commentaires = Commentaire.all
		render "user/dashboard", layout: "layout"
	end
	## nouvelle publication
	def new_publication
		@publication = Publication.new
		render "user/new_pub", layout: "layout"
	end
	def new_publication_form
		#@content = pub_params[:content]
		#@image = pub_params[:image]
		#session[:pub_image] = pub_params[:image]
		#session[:pub_content] = pub_params[:content]
		@publication = Publication.new(pub_params)
		@publication.user_id = session[:current_user_id]
		@publication.published_at = Time.now
		if @publication.save
			flash[:pub_success] = "Post publié avec succès"
			redirect_to '/users/dashboard'
		else
			flash[:pub_errors] = @publication.errors.full_messages
			redirect_to '/users/new_publication'
		end 
	end
	def destroy_pub
		@publication = Publication.find(params[:id])
	    @publication.destroy
	    flash[:pub_destroy] = "Post supprimé avec succès"
	    redirect_to '/users/dashboard'
	end
	def destroy
	    session[:current_user_id] = nil
	    flash[:notice_logout] = "Déconnection réussie"
	    redirect_to '/'
	end
	def edit
		@publication = Publication.find(params[:id])
		render "user/edit", layout: "layout"
	end
	def editform
		@publication = Publication.find(params[:id])
		if @publication.update(pub_params)
			flash[:pub_update] = "Post mis à jour avec succès"
			redirect_to '/users/dashboard'
		else
			flash[:pub_update_errors] = @publication.errors.full_messages
  			redirect_to users_edit_path(@publication)
  		end
	end
	def comment
		@commentaire = Commentaire.new
		session[:current_publication_id] = params[:id]
		render "user/comment", layout: "layout"
	end
	def comment_form
		@commentaire = Commentaire.new(comment_params)
		@commentaire.user_id = session[:current_user_id]
		@commentaire.publication_id = session[:current_publication_id]
		if @commentaire.save
			flash[:comment_success] = "Commentaire publiée avec succès"
			redirect_to '/users/dashboard'
		else
			flash[:comment_errors] = @commentaire.errors.full_messages
  			redirect_to users_comment_path(session[:current_publication_id])
		end
	end
	def profil
		@user = User.find(session[:current_user_id])
		render "user/profil", layout: "layout"
	end
	def new_publication_confirmation
		#@image = session[:pub_image]
		#@content = session[:pub_content]
		render "user/new_pub_confirm", layout: "layout"
	end
	def new_publication_confirmation_form
		@new_pub = Publication.new(pub_params)
		@new_pub.user_id = session[:current_user_id]
		@new_pub.published_at = Time.now
		if @new_pub.save
			redirect_to '/users/dashboard'
		else
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

	    def pub_params
	        params.require(:publication).permit(:content, :image )
	    end
	    def comment_params
	        params.require(:commentaire).permit(:content)
	    end
end
