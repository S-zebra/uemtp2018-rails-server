json.result @posts do |p|
  json.id p.id
  json.latitude p.latitude
  json.longitude p.longitude
  json.text p.text
end
