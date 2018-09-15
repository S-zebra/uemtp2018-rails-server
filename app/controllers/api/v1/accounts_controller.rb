class Api::V1::AccountsController < ApiController
  def available?
    token = Token.find_by(token: params[:token])
    if token && token.account
      render json: {status: 200, message: "available"}
    else
      render json: {status: 200, message: "unavailable"}
    end
  end
end
