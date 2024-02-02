class ChangeColumnNameToReservation < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :reservation_date, :date
  end
end
