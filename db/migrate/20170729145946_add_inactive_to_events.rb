class AddInactiveToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :inactive, :boolean
  end
end
