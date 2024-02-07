class ChangeAndRemoveDataTypeToBus < ActiveRecord::Migration[7.1]
  def change
    change_column :buses, :departure_time, :time
    remove_column :buses, :destination_time, :time
  end
end
