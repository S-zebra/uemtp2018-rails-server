json.result @posts do |p|
  json.id p.id
  json.latitude p.latitude
  json.longitude p.longitude
  json.parent p.parent ? p.parent.id : -1
  json.text p.text
end
