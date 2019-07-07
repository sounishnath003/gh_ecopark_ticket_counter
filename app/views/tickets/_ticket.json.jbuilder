json.extract! ticket, :id, :date, :persons, :price, :sub_total, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
