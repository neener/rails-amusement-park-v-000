class Ride < ActiveRecord::Base
	belongs_to :user
	belongs_to :attraction

	def take_ride
		has_tickets, has_height = ok_to_ride
		if has_tickets && has_height
			after_ride
		elsif has_tickets && !has_height
			"Sorry. " + not_tall_enough
		elsif has_height && !has_tickets
			"Sorry. " + not_enough_tickets
		else
			"Sorry. " + not_enough_tickets + " " + not_tall_enough
		end
	end

	def ok_to_ride
		has_tickets, has_height = false
		if self.user.tickets >= self.attraction.tickets
			has_tickets = true
		end
		if self.user.height >= self.attraction.min_height
			has_height = true
		end
		return [has_tickets, has_height]
	end

	def after_ride
		new_happiness = self.user.happiness += self.attraction.happiness_rating
		new_nausea = self.user.nausea += self.attraction.nausea_rating
		new_tickets = self.user.tickets -= self.attraction.tickets
		self.user.update(
			:happiness => new_happiness,
			:nausea => new_nausea,
			:tickets => new_tickets
			)
	end

	def not_enough_tickets
		"You do not have enough tickets to ride the #{self.attraction.name}."
	end

	def not_tall_enough
		"You are not tall enough to ride the #{self.attraction.name}."
	end
end
