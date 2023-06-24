json.result @locations do |i|
  json.id i.id
  json.latitude i.latitude
  json.longitude i.longitude
  json.datetime i.created_at
end
