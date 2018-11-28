json.id @post.id
json.latitude @post.latitude
json.longitude @post.longitude
json.parent @post.parent.id ? @post.parent : -1
json.text @post.text
