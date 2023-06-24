class TokensController < ApplicationController
  before_action :check_session

  def index
    @tokens = Token.where(account: @account)
  end

  def create
    @token_string = SecureRandom::base58
    @new_token = Token.new(account: @account, token: @token_string)
  end

  private

  def check_session
    @account = Account.find_by(id: session[:uid])
    redirect_to :root unless @account
  end
end
