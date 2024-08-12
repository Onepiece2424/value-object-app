class UsersController < ApplicationController
  def index
    @users = User.all
  end

  private
  def users_params
    params.require(:user).permit(:post_code)
  end
end
