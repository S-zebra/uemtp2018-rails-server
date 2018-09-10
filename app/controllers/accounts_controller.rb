class AccountsController < ApplicationController
  before_action :check_session, only: [:show]

  def show
    @token = Token.find_by(account: @account)
  end

  def new
    @new_account = @new_account || Account.new
  end

  def create
    bd_keys = %i(birthday(1i) birthday(2i) birthday(3i))
    new_params = params.require(:account).permit([:name, :password, :password_confirmation, :sex] + bd_keys)
    bd_array = [new_params[bd_keys[0]], new_params[bd_keys[1]], new_params[bd_keys[2]]].map(&:to_i)
    birthday = Date.new(bd_array[0], bd_array[1], bd_array[2])

    @new_account = Account.new(
      name: new_params[:name],
      password: new_params[:password],
      birthday: birthday,
      sex: new_params[:sex],
    )

    @new_token = Token.new(account: @new_account, token: SecureRandom::base58) #トークンを1つ作る

    if @new_account.save && @new_token.save
      flash[:notice] = "アカウントが登録されました"
      session[:uid] = @new_account.id
      redirect_to action: "show", id: @new_account.id
    else
      flash[:form_errors] = @new_account.errors.full_messages
      redirect_to action: "new"
    end
  end

  private

  def check_session
    @account = Account.find_by(id: session[:uid])
    if !@account || params[:id] != session[:uid].to_s
      raise ArgumentError.new
      flash[:error] = "ログインされていないか、または不正な画面遷移が起こりました。再度ログインしてください。"
      redirect_to :root
    end
  end
end
