class AttendeeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.attendeersvp_mailer.normal.subject
  #
  def rsvp(attendee, event, subject = "", message="")
    @attendee = attendee
    @event = event
    @message = message
    if subject.empty?
    	mail to: attendee.email, subject: "Confirm your attendance for #{@event.name}"
  	else
  		mail to: attendee.email, subject: subject
  	end
  end

  def normal(attendee, event, subject, message)
  	@name = attendee.name
  	@event = event
  	@message = message
	 	mail to: attendee.email, subject: subject
  end
end
