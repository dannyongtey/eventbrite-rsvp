require 'test_helper'

class AttendeeMailerTest < ActionMailer::TestCase
  test "normal" do
    mail = AttendeersvpMailer.normal
    assert_equal "Normal", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
