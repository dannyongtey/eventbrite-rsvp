class Event < ApplicationRecord

	def self.updatedb(events) 
		Event.destroy_all
		Event.reset_pk_sequence
		events.each do |event|
			 name = event["name"]["text"]
			 time = Event.convert_datetime(event["start"]["local"])
			 uid = event["id"].to_i
			 url = event["url"]
			 capacity = event["capacity"].to_i
			 Event.create(name: name, time: time, uid: uid, url: url, capacity: capacity)
		end
	end

	def self.convert_datetime(ori_datetime)
		date_time = ori_datetime.split("T")
		date = date_time[0].split("-").map(&:to_i)
		time = date_time[1].split(":").map(&:to_i)
		DateTime.new(date[0], date[1], date[2], time[0], time[1], time[2])
	end
end
