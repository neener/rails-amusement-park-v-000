class UsersController < ApplicationController
	# before_action :set_user, only: [:show, :edit, :update, :destroy]
	

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def show
		if !logged_in? || current_user.id != params[:id].to_i
			redirect_to '/' and return
		end
		@user = User.find(params[:id])
	end

	private

		def user_params
			params.require(:user).permit(:name, :password, :nausea, :happiness, :height, :tickets, :admin)
		end

		# def set_user
		# 	@user = User.find(params[:id])
		# end
end