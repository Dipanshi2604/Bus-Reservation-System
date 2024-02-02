class RemoveColumnFromYourReservation < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :date_time, :date
  end
end
