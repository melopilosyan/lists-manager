json.orders @orders do |order|
  json.id order.id
  json.name order.name
  json.status order.status_name
  json.madeOn order.created_at_humanize

  json.creator do
    json.id order.user.id
    json.name order.user.name
  end

  json.meals order.meals do |meal|
    json.id meal.id
    json.name meal.name
    json.addedOn meal.created_at_humanize

    json.creator do
      json.id meal.user.id
      json.name meal.user.name
    end
  end
end
