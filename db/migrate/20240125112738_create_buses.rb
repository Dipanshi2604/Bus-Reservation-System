class CreateBuses < ActiveRecord::Migration[7.1]
  def change
    create_table :buses do |t|
      t.string :title
      t.integer :total_seats
      t.string :source
      t.string :destination
      t.datetime :arrival_time
      t.datetime :departure_time
      t.integer :registration_no
      t.references :bus_owner, foreign_key: { to_table: :users } 
      t.timestamps
    end
  end
end
