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

  def count
    # authenticate
    msg = ""
    Account.all.each do |acc|
      msg << "#{acc.name}: #{Post.where(account: acc).length}\n"
    end
    render plain: msg
  end

  def show
    # authenticate
    begin
      @posts = [Post.find(params[:id])]
      render template: "api/v1/posts/index"
    rescue ActiveRecord::RecordNotFound
      render json: {status: 404, message: "No such post"}, status: 404
    end
  end

  def add_location
    authenticate
    json = JSON.parse(request.body.read)
    location = Location.new(
      account: @account,
      latitude: json["lat"],
      longitude: json["lon"],
      post: Post.find(json["id"].to_i),
    )
    if location.save
      render json: {status: 200, message: "OK"}
    else
      errors = location.errors.full_messages
      p errors
      render json: {status: 400, message: "Location is invalid", detailMessages: errors}, status: 400
    end
  end

  #じぇーそん受け取り処理
  def create
    json = JSON.parse(request.body.read)
    rep_to = nil
    if json["parentId"]
      begin
        rep_to = Post.find(json["parentId"].to_i)
      rescue ActiveRecord::RecordNotFound
        puts "Can't find post with id = #{json["parentId"]}"
      end
    end
    post = Post.new(
      account: @account,
      latitude: json["lat"],
      longitude: json["lon"],
      text: json["text"],
      parent: rep_to,
    )
    p json
    if post.save
      render json: {status: 200, message: "OK"}
    else
      errors = post.errors.full_messages
      puts errors
      render json: {status: 400, message: "Post is invalid", detailMessages: errors}, status: 400
    end
  end
end
