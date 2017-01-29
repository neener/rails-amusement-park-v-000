class RidesController < ApplicationController

	def new
		@ride = Ride.new
	end

	  def create
	    @ride = Ride.new(ride_params)
	    @ride.save
	    if @ride.take_ride.class == String
	      flash[:alert] = @ride.take_ride
	    else
	      flash[:alert] = "Thanks for riding the #{@ride.attraction.name}!"
	    end
	    redirect_to user_path(current_user)
	  end

	# def create
	# 	# raise params.inspect
	# 	@ride = Ride.new(ride_params)
	# 	if @ride.save
	# 		current_user.update(tickets: current_user.tickets - @ride.attraction.tickets, nausea: @ride.attraction.nausea_rating, happiness: @ride.attraction.happiness_rating)
	# 		redirect_to user_path(current_user)		
	# 	else
	# 		render 'new'
	# 	end
	# end

	private

	def ride_params
		params.require(:ride).permit(:user_id, :attraction_id)
	end

end