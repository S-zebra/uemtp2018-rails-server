json.result @post do |p|
  json.id p.id
  json.latitude p.latitude
  json.longitude p.longitude
  json.parent p.parent ? p.parent.id : -1
  json.text p.text

  json.locations p.location do |l|
    json.latitude l.latitude
    json.longitude l.longitude
    json.createdAt l.created_at
  end
end
