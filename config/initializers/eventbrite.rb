class AccessEventbrite
	include HTTParty
  
	
	@@base_uri = "https://www.eventbriteapi.com/v3"
	attr_accessor :token

	def initialize(token)
		@token = token
		
	end

	def parameterize(params = {})
		parameters = ""
		params.each do |key, value|
			parameters += "&#{key}=#{value}"
		end
		parameters
	end

	def owned_events(params = {})
		parameters = parameterize(params)
		response = HTTParty.get(@@base_uri + "/users/me/owned_events/?token=#{@token}" + parameters)
		response["events"]		
	end

	def attendees(id, params = {})
		parameters = parameterize(params)
		page_count = HTTParty.get(@@base_uri + "/events/#{id}/attendees/?token=#{@token}" + parameters)["pagination"]["page_count"].to_i
		attendees = []
		(1..page_count).each do |count|
			response = HTTParty.get(@@base_uri + "/events/#{id}/attendees/?token=#{@token}&page=#{count}" + parameters)
			response["attendees"].each do |attendee|
				attendees << attendee
			end
		end
		attendees
	end

		
end