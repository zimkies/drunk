class ChampionsController < ApplicationController
  def create
    champion = Champion.new(champion_params)
    if champion.save
      send_welcome_message(champion)
      redirect_to :back
    else
      flash[:warning] = champion.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private

  def client
    @client ||= Twilio::REST::Client.new
  end

  def send_welcome_message(champion)
    client.messages.create(
      from: ENV.fetch('TWILIO_CX_NUMBER'),
      to: champion.phone_number,
      body: "Hey #{champion.name}. Your friend #{champion.user.name} is taking steps towards limiting #{champion.user.vice} in their life. They have asked you to be their guardian!"
    )

    sleep(0.5)

    client.messages.create(
      from: ENV.fetch('TWILIO_CX_NUMBER'),
      to: champion.phone_number,
      body: "We'll let you know if they stray over the limits we've set in #{champion.user.vice}, and it will be your job to make sure they don't do any more until they've balanced it with a good act."
    )
  end

  def champion_params
    params.require(:champion).permit(:name, :phone_number, :user_id)
  end
end
