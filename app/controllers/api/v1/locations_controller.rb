class Api::V1::LocationsController < ApiController
  before_action :authenticate

  def index
    @locations = Location.where(account: @account)
  end

  def create
    json = JSON.parse(request.body.read)
    new_location = Location.new(
      account: @account,
      latitude: json["lat"],
      longitude: json["lon"],
    )
    if new_location.save
      render json: {status: 200, message: "OK"}
    else
      render json: {status: 400,
                    message: "Post is invalid",
                    detailMessage: new_location.errors.full_messages},
             status: 400
    end
  end
end
