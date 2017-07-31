class AddTickettypeToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :tickettype, :string
  end
end
