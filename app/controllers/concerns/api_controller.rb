class ApiController < ActionController::Base
  rescue_from ArgumentError, with: :invalid_params
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_token
  before_action :authenticate, only: [:create]
  skip_before_action :verify_authenticity_token #トークン認証を飛ばす (そうしないとAPIが多々県)

  def invalid_params(e)
    render json: {status: 400, message: "Parameter is invalid", detailMessage: e.message}, status: 400
  end

  def invalid_token
    render json: {status: 403, message: "Token is invalid"}, status: 403
  end

  private

  def authenticate
    token = JSON.parse(request.body.read)["token"]
    @account = Token.find_by!(token: token).account
  end
end
