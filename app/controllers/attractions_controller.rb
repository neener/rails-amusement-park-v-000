class AttractionsController < ApplicationController
	before_action :set_attraction, only: [:show, :edit, :update]

	def index
		@attractions = Attraction.all
	end

	def show
		redirect_to '/' unless logged_in?
		@ride = Ride.new(attraction_id: params[:id])
	end

	def new
		@attraction = Attraction.new
	end

	def create
		@attraction = Attraction.new(attraction_params)
		if @attraction.save
			redirect_to attraction_path(@attraction)
		else
			render 'attractions/new'
		end
	end

	def edit
		@attraction = Attraction.find(params[:id])
	end

	def update
		@attraction = Attraction.find(params[:id])
		@attraction.update(attraction_params)
		flash[:notice] = "Attraction was successfully updated."
		redirect_to attraction_path(@attraction)
	end

	private

		def attraction_params
			params.require(:attraction).permit(:name, :min_height, :tickets, :happiness_rating, :nausea_rating)
		end

		def set_attraction
			@attraction = Attraction.find(params[:id])
		end

end