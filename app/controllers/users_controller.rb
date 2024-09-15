class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def csv_output
    @users = User.all
    send_data(User.csv_format(@users), filename: "ユーザー一覧.csv")
  end

  private
  def users_params
    params.require(:user).permit(:post_code)
  end
end
