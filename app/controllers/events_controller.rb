class EventsController < ApplicationController

	def index
		api_caller = AccessEventbrite.new(ENV["eventbrite_oauth"])
		Event.updatedb(api_caller.owned_events({status: "live"}))		
		@events = Event.all
	end

	def update
		api_caller = AccessEventbrite.new(ENV["eventbrite_oauth"])
		Event.updatedb(api_caller.owned_events({status: "live"}))
	end

end
