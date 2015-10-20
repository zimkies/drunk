class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:warning] = user.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def user_params
    params.require(:user).permit(:name, :vice)
  end
end
