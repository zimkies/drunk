class KarmaEventsController < ApplicationController
  def create
    KarmaEvent.create(
      karma_event_params.merge(
        user_id: user.id,
        points: karma_event_params[:points].to_i || 0
      )
    )
    redirect_to :back
  end

  def karma_event_params
    params.require(:karma_event).permit(:points)
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
