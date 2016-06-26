json.item do
  json.id @item.id
  json.name @item.name
  json.addedOn @item.created_at_humanize
  json.allowActions @item.user.id == current_user.id

  json.creator do
    json.id @item.user.id
    json.name @item.user.name
  end
end
