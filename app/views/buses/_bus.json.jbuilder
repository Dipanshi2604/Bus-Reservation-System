json.extract! bus, :id, :title, :total_seats, :source, :destination, :arrival_time, :departure_time, :registration_no, :bus_owner_id, :created_at, :updated_at
json.url bus_url(bus, format: :json)
