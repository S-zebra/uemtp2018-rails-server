class Api::V1::PostsController < ApiController
  def index
    if params[:lat] && params[:lon]
      lat = params[:lat].to_f
      lon = params[:lon].to_f
      @posts = Post.where(latitude: lat - 1..lat + 1, longitude: lon - 1..lon + 1)
    else
      @posts = Post.all
    end
  end

  def show
    #@post = Post.find()
  end

  #じぇーそん受け取り処理
  def create
    json = JSON.parse(request.body.read)
    post = Post.new(
      account: @account,
      latitude: json["lat"],
      longitude: json["lon"],
      text: json["text"],
    )
    p json
    if post.save
      render json: {status: 200, message: "OK"}
    else
      errors = post.errors.full_messages
      render json: {status: 400, message: "Post is invalid", detailMessages: errors}, status: 400
    end
  end
end
