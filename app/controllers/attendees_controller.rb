class AttendeesController < ApplicationController
	def index
		@attendees = Event.find(params[:event_id]).attendees.all
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
				redirect_to root_path(message: true)
			elsif attendee && attendee.digest == params[:token] && params[:status] == "false"
				attendee.update_attributes(attending: false)
				flash[:success] = "You have responded successfully"
				redirect_to root_path(message: false)
			else
				flash[:danger] = "There was something wrong with the RSVP process."
				redirect_to root_path(message: "Error")
			end
		end
		
	end


	private
	def filter_target(parameter, event_id)
		event = Event.find(event_id)
		attending_true = "haha"
		attending_false = "haha"
		response = "haha"
		token = "haha"
		if parameter[:attending] == "1"
			attending_true = true
		end
		if parameter[:not_attending] == "1"
			atteding_false = false
		end

		if parameter[:no_response] == "1"
			response = nil
		end

		if parameter[:not_sent] == "1"
			token = nil
		end

		if parameter[:all] == "1"
			event.attendees.all
		else
		end


	end
end
