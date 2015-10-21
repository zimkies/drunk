class KarmaEventsController < ApplicationController
  def create
    KarmaEvent.create!(
      karma_event_params.merge(
        user_id: user.id,
        points: karma_event_params[:points].to_i || 0
      )
    )

    if transitioned_to_bad?
      message_champion_bad
    elsif transitioned_from_bad_to_ok?
      message_champion_good
    end

    redirect_to :back
  end

  private

  def client
    @client ||= Twilio::REST::Client.new
  end

  def message_champion_bad
    champion = user.champion
    client.messages.create(
      from: ENV.fetch('TWILIO_CX_NUMBER'),
      to: champion.phone_number,
      body: "Hey #{champion.name}. Your friend #{user.name} as gone over their #{user.vice} limit - don't allow them any more until they've done something good to counter it!"
    )
  end

  def message_champion_good
    champion = user.champion
    client.messages.create(
      from: ENV.fetch('TWILIO_CX_NUMBER'),
      to: champion.phone_number,
      body: "Hey #{champion.name}. Good news! Your friend #{user.name} has done some good acts, and they've earned the right to #{user.vice} again!"
    )
  end

  def transitioned_from_bad_to_ok?
    user.karma == User::VICE_THRESHOLD &&
    user.karma_events.last.positive?
  end

  def transitioned_to_bad?
    user.karma == User::VICE_THRESHOLD - 1 &&
    user.karma_events.last.negative?
  end

  def karma_event_params
    params.require(:karma_event).permit(:points)
  end

  def user
    @user ||= User.find(params[:user_id])
  end
end
