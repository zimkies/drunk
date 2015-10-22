class KarmaReminder
  delegate :user_url, to: 'Rails.application.routes.url_helpers'
  def run
    users.map { |user| notify_user(user) }
  end

  def notify_user(user)
    if active_today?(user)
      # if over limit say NO MORE
      if user.bad?
        mark_user_as_notified(user)
        client.messages.create(
          from: ENV.fetch('TWILIO_CX_NUMBER'),
          to: user.phone_number,
          body: "Hey there #{user.name}. You are over your quota of #{user.vice} today, make sure you don't do any more until you've balanced your karma: #{user_url(user)}"
        )
      end

    # user hasn't been active today
    else
      mark_user_as_notified(user)
      client.messages.create(
        from: ENV.fetch('TWILIO_CX_NUMBER'),
        to: user.phone_number,
        body: "Hey there #{user.name}. You haven't let us know how #{user.vice} went today. We're concerned for you, let us know! #{user_url(user)}"
      )
    end
  rescue => e
    p "error: #{e}"
    Rollbar.warn(e)
  end

  def client
    @client ||= Twilio::REST::Client.new
  end

  def users
    users = User.all.where("last_karma_reminded_at < ?", Time.zone.now.midnight)
    p "Notifying #{users.count} users"
    users
  end

  def active_today?(user)
    user.karma_events.where("created_at > ?", Time.zone.now.midnight).exists?
  end

  def mark_user_as_notified(user)
    user.update_attributes!(last_karma_reminded_at: Time.zone.now)
  end
end

KarmaReminder.new.run
