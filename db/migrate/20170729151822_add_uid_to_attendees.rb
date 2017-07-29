class AddUidToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :uid, :bigint
  end
end
