class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :uid
      t.string :name
      t.string :url
      t.datetime :time
      t.integer :capacity

      t.timestamps
    end
  end
end
