class EventsController < ApplicationController

	def index
		@events = Event.all
	end

	def update
		api_caller = AccessEventbrite.new(ENV["eventbrite_oauth"])
		Event.updatedb(api_caller.owned_events({status: "live"}), api_caller)
		redirect_to events_path
	end

end
