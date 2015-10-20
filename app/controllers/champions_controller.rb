class ChampionsController < ApplicationController
  def create
    champion = Champion.new(champion_params)
    if champion.save
      redirect_to :back
    else
      flash[:warning] = champion.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def champion_params
    params.require(:champion).permit(:name, :phone_number, :user_id)
  end
end
