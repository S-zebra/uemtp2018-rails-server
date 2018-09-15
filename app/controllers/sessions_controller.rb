class SessionsController < ApplicationController
  def new
  end

  def create
    a_params = params.permit([:user_name, :password])
    account = Account.authenticate(a_params[:user_name], a_params[:password])
    if account
      session[:uid] = account.id
      flash[:notice] = "ログインしました。"
      @token = account.tokens.first.token
    else
      flash[:error] = "ログインに失敗しました。再度お試しください。"
      redirect_to action: "new"
    end
  end
end
