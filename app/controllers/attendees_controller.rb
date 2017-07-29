class AttendeesController < ApplicationController
	def index
		@attendees = Event.find(params[:event_id]).attendees.all
	end
end
