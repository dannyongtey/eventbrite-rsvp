class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.string :name
      t.string :email
      t.boolean :attending
      t.string :digest
      t.datetime :sent_at
      t.datetime :rsvp_at
      t.text :notes

      t.timestamps
    end
  end
end
