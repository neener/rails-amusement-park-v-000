class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	def create
		# binding.pry
		@user = User.find_by(name: params[:user][:name])
   		if @user && @user.authenticate(params[:user][:password])
      		session[:user_id] = @user.id
      		redirect_to user_path(@user)
    	else
      		render root_path
    	end
	end

	def destroy
		session.clear
		redirect_to root_path
	end
	
end