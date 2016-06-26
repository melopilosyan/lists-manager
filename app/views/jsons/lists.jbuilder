json.lists @lists do |list|
  json.id list.id
  json.name list.name
  json.state list.state
  json.madeOn list.created_at_humanize
  json.allowActions list.user.id == (current_user.id rescue 0)

  json.creator do
    json.id list.user.id
    json.name list.user.name
  end

  json.items list.items do |item|
    json.id item.id
    json.name item.name
    json.addedOn item.created_at_humanize
    json.allowActions item.user.id == (current_user.id rescue 0)

    json.creator do
      json.id item.user.id
      json.name item.user.name
    end
  end
end
