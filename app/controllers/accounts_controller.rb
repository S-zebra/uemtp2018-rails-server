class AccountsController < ApplicationController
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
    if @new_account.save
      flash[:notice] = "アカウントが登録されました"
    else
      flash[:form_errors] = @new_account.errors.full_messages
    end
    redirect_to action: "new"
  end
end
