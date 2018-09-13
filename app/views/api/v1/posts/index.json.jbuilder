json.result @posts do |p|
  json.id p.id
  json.latitude p.latitude
  json.longitude p.longtitude
  json.text p.text
end
