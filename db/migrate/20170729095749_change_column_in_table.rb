class ChangeColumnInTable < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :uid, :bigint
  end
end
