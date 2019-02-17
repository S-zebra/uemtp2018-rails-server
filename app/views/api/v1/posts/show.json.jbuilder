json.id @post.id
json.latitude @post.latitude
json.longitude @post.longitude
json.parent @post.parent ? @post.parent.id : -1
json.text @post.text

json.locations @post.location do |l|
  json.latitude l.latitude
  json.longitude l.longitude
  json.createdAt l.created_at
end
