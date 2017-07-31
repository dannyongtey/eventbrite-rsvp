class Event < ApplicationRecord
	has_many :attendees, dependent: :destroy

	def self.updatedb(events, caller)
		api_uid_list = []
		db_uid_list = []
		events.each do |event|
			api_uid_list << event["id"].to_i
		end

		existing_events = Event.all

		existing_events.each do |event|
			db_uid_list << event.uid
		end

		outdated_uid_list = db_uid_list - api_uid_list
		#Destroying outdated events
		outdated_uid_list.each do |uid|
			Event.find_by(uid: uid).update_attributes(inactive: true)
		end

		events.each do |event|
			name = event["name"]["text"]
			time = Event.convert_datetime(event["start"]["local"])
			uid = event["id"].to_i
			url = event["url"]
			capacity = event["capacity"].to_i
			if Event.exists?(uid: uid) 
				Event.find_by(uid: uid).update_attributes(name: name, time: time, url: url, capacity: capacity, inactive: false) 
			else
				event = Event.create(name: name, time: time, uid: uid, url: url, capacity: capacity, inactive: false)
			end
	
			live_events = Event.where(inactive: false)
			live_events.each do |event|
				latest_attendees = caller.attendees(event.uid)
				latest_attendees.each do |attendee|
					name = attendee["profile"]["name"]
					email = attendee["profile"]["email"]
					ticket_type = attendee["ticket_class_name"]
					uid = attendee["id"].to_i
					if event.attendees.exists?(uid: uid)
						event.attendees.find_by(uid: uid).update_attributes(name: name, email: email, tickettype: ticket_type)
					else
						event.attendees.create(name: name, email: email, uid: uid, tickettype: ticket_type)
					end

				end
				db_uid = event.attendees.pluck(:uid)
				latest_uid = latest_attendees.map do |attendee| 
					if attendee["cancelled"]==false 
						attendee["id"].to_i
					else
						next
					end
				end
				cancelled_uid = db_uid - latest_uid
				cancelled_uid.each do |uid|
					event.attendees.find_by(uid: uid).destroy
				end
			end
			 #attendees = caller.attendees(uid)
			 #attendees.each do |attendee|

			 #end

		end

	end

	def self.convert_datetime(ori_datetime)
		date_time = ori_datetime.split("T")
		date = date_time[0].split("-").map(&:to_i)
		time = date_time[1].split(":").map(&:to_i)
		DateTime.new(date[0], date[1], date[2], time[0], time[1], time[2])
	end
end
