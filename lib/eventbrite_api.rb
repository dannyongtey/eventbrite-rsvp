class AccessEventbrite
	include HTTParty
	base_uri = "https://www.eventbriteapi.com/v3"

	attr_accessor :token

	def initialize(token)
		@token = token
	end

	def owned_events
		reponse = get(base_uri + "/")
	end

	def attendees(id)
		response = get(base_uri + "/events/#{id}/attendees/?token=#{@token}")
	end
		





