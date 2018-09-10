class Api::V1::PostsController < ApiController
  def index
    raise ArgumentError.new("lat and lon must be given") unless params[:lat] && params[:lon]
    lat = params[:lat]
    lon = params[:lon]
    @posts = Post.where(latitude: lat, longtitude: lon)
  end

  def show
    #@post = Post.find()
  end

  #じぇーそん受け取り処理
  def create
    render json: JSON.parse(request.body).to_h
  end
end
