class Api::V1::PostsController < ApiController
  def index
    if params[:lat] && params[:lon]
      lat = params[:lat].to_f
      lon = params[:lon].to_f
      @posts = Post.where(latitude: lat - 1..lat + 1, longitude: lon - 1..lon + 1)
      puts "Posts are: #{@posts}"
    elsif (params[:lat1] && params[:lat2]) && (params[:lon1] && params[:lon2])
      @posts = Post.where(latitude: params[:lat2].to_f..params[:lat1].to_f, longitude: params[:lon1].to_f..params[:lon2].to_f)
    else
      @posts = Post.all
    end
    @posts.limit!(params[:limit]) if params[:limit].to_i > 0
    begin
      @posts.order!("#{params[:order]} #{"DESC" if ["1", "true"].include?(params[:desc])}") if params[:order]
    rescue
      puts "No such column: #{params[:order]}"
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

  def dump
    authenticate
    posts = Post.all
    if params[:lat1] && params[:lat2]
      lat_range = params[:lat1]..params[:lat2]
      posts.where!(lat: lat_range)
    end
    if params[:lon1] && params[:lon2]
      lon_range = params[:lon1]..params[:lon2]
      posts.where!(lon: lon_range)
    end
    if params[:user]
      user = Account.find_by(name: params[:user])
      posts.where!(account: account)
    end
    res = ""
    posts.each do |p|
      res << "#{p.id},#{p.account.name},#{p.latitude},#{p.longitude},\"#{p.text}\",#{p.created_at.in_time_zone("Asia/Tokyo")}\n"
    end
    render plain: res
  end

  def show
    # authenticate
    begin
      @posts = [Post.find(params[:id])]
      while @posts.last.parent
        @posts << Post.find(@posts.last.parent)
      end
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
