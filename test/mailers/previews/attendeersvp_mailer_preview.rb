# Preview all emails at http://localhost:3000/rails/mailers/attendeersvp_mailer
class AttendeersvpMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/attendeersvp_mailer/normal
  def normal
  	attendee = Attendee.find_by(email: "dannyongtey@gmail.com")
  	attendee.update_attributes(digest: SecureRandom::urlsafe_base64)
    AttendeeMailer.normal(attendee, Event.second, subject = "Diu", message = "hahaha")
  end

  def rsvp
  	attendee = Attendee.find_by(email: "dannyongtey@gmail.com")
  	attendee.update_attributes(digest: SecureRandom::urlsafe_base64)
    AttendeeMailer.rsvp(attendee, Event.second, subject = "Diu", message = "hahaha")
  end
end
