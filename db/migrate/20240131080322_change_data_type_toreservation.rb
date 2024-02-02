class ChangeDataTypeToreservation < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :date_time, :date
  end
end
