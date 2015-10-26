class UsersController < ApplicationController

  def show
      @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      redirect_to user_url(user.id)
    else
      flash[:error] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private
  def user_params
    self.params.require(:user).permit(:username, :password)
  end
end
