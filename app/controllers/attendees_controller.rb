class AttendeesController < ApplicationController
	skip_before_action :authenticated?, only: [:update, :explain]
	def index
		@event = Event.find(params[:event_id])
		@attendees = @event.attendees.all
		
	end

	def email

	end

	def sending

		target_attendees = filter_target(params[:send], params[:event_id])
		event = Event.find(params[:event_id])
		subject = params[:send][:subject]
		message = params[:send][:content]
		if params[:send][:type] == "RSVP"
			target_attendees.each do |attendee|
				token = SecureRandom::urlsafe_base64
				attendee.update_attributes(digest: token, attending: nil)
				AttendeeMailer.rsvp(attendee, event, subject, message).deliver_now
			end
		else
			target_attendees.each do |attendee|
				token = SecureRandom::urlsafe_base64
				AttendeeMailer.normal(attendee, event, subject, message).deliver_now
			end
		end
		flash[:success] = "Email sent!"
		redirect_to event_attendees_path(event_id: params[:event_id])
	end

	def update
		event = Event.find_by(uid: params[:event_uid])
		if event
			attendee = event.attendees.find_by(email: params[:email])
			if attendee && attendee.digest == params[:token] && params[:status] == "true"
				attendee.update_attributes(attending: true)
				flash[:success] = "You have responded successfully"
				redirect_to landing_path(message: true)
			elsif attendee && attendee.digest == params[:token] && params[:status] == "false"
				attendee.update_attributes(attending: false)
				flash[:success] = "You have responded successfully"
				redirect_to landing_path(message: false, email: params[:email], event_uid: params[:event_uid], token: params[:token])
			else
				flash[:danger] = "There was something wrong with the RSVP process."
				redirect_to landing_path(message: "Error")
			end
		end
		
	end

	def explain
		if params[:reason][:notes] && params[:reason][:email] && params[:reason][:token] && params[:reason][:event_uid]
			if event = Event.find_by(uid: params[:reason][:event_uid])
				if attendee = event.attendees.where(email: params[:reason][:email], digest: params[:reason][:token], attending: false).first
					attendee.update_attributes(notes: params[:reason][:notes])
				else
					flash[:danger] = "Authentication error."
				end
			else 
				flash[:danger] = "Authentication error."	
			end
		else
			flash[:danger] = "Authentication error."
		end
			redirect_to landing_path
	end 

	def disable
		event = Event.find(params[:event_id])
		if event
			attendees = event.attendees.all
			attendees.each do |attendee|
				attendee.update_attributes(digest: nil)
			end
		end
		redirect_to event_attendees_path(event_id: params[:event_id])
	end


	private
	def filter_target(parameter, event_id)
		event = Event.find(event_id)
		if parameter[:all] == "1"
			return event.attendees.all
		else
			arr1 = []
			arr2 = []
			arr3 = []
			arr4 = []
=begin
				query_string = "attending= ? OR attending= ? OR (attending= ? AND digest IS NOT ?) OR digest= ?"
				attending_true = "haha"
				attending_false = "haha"
				responding = "haha"
				response = "haha"
				token = "haha"
=end
			if parameter[:attending] == "1"
				arr1 = event.attendees.where(attending: true)
			end
			if parameter[:not_attending] == "1"
				arr2 = event.attendees.where(attending: false)
			end

			if parameter[:no_response] == "1"
				arr3 = event.attendees.where(attending: nil).where.not(digest: nil)
			end

			if parameter[:not_sent] == "1"
				arr4 = event.attendees.where(attending: nil, digest: nil)
			end
			list = (arr1+arr2+arr3+arr4).uniq
			return list
		end
		




	end
end
