json.meal do
  json.id @meal.id
  json.name @meal.name
  json.addedOn @meal.created_at_humanize
  json.allowActions @meal.user.id == current_user.id

  json.creator do
    json.id @meal.user.id
    json.name @meal.user.name
  end
end
