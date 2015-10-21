class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def sign_in
  end

  def send_home_page
    phone_number = PhoneNumber.new(params[:phone_number]).to_s
    if phone_number.present? && (user = User.find_by_phone_number(phone_number)).present?
      client.messages.create(
        from: ENV.fetch('TWILIO_CX_NUMBER'),
        to: phone_number,
        body: "Hey there #{user.name}. Here's your guardian page: #{user_url(user)}"
      )

      flash[:success] = "Great! We texted it to you"
    else
      flash[:warning] = "'#{params[:phone_number]}' is not a a registered phone number in our system. Are you sure you signed up? "
    end
    redirect_to :back
  end

  def create
    user = User.new(user_params)
    if user.save
      send_welcome_message(user)
      redirect_to user_path(user)
    else
      flash[:warning] = user.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private

  def client
    @client ||= Twilio::REST::Client.new
  end

  def send_welcome_message(user)
    client.messages.create(
      from: ENV.fetch('TWILIO_CX_NUMBER'),
      to: user.phone_number,
      body: "Hey there #{user.name}. Great job in taking the first steps to limit #{user.vice}! Text me back if you need any help or have any feedback :)"
    )
  end

  def user_params
    params.require(:user).permit(:name, :vice, :phone_number)
  end
end
