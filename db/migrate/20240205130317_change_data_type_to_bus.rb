class ChangeDataTypeToBus < ActiveRecord::Migration[7.1]
  def change
    change_column :buses, :arrival_time, :time
    change_column :buses, :destination_time, :time
  end
end
