json.extract! trip, :id, :title, :date, :notes, :created_at, :updated_at
json.url trip_url(trip, format: :json)
