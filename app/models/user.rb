class User < ActiveRecord::Base
  VICE_THRESHOLD = -2
  VIRTUE_THRESHOLD = +2

  has_one :champion
  has_many :karma_events
  validates :vice, :name, :phone_number, presence: :true

  def phone_number=(phone_number)
    write_attribute(:phone_number, PhoneNumber.new(phone_number).to_s)
  end

  def championed?
    champion.present?
  end

  def karma
    karma_events.sum(:points)
  end

  def negative_karma
    karma_events.negative.sum(:points) || 0
  end

  def positive_karma
    karma_events.positive.sum(:points) || 0
  end

  def good?
    karma > VIRTUE_THRESHOLD
  end

  def ok?
    !(good? || bad?)
  end

  def bad?
    karma < VICE_THRESHOLD
  end
end
