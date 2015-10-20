class User < ActiveRecord::Base
  VICE_THRESHOLD = 3
  VIRTUE_THRESHOLD = -3

  has_one :champion
  has_many :karma_events
  validates :vice, :name, presence: :true

  def championed?
    champion.present?
  end

  def karma
    karma_events.sum(:points)
  end

  def negative_karma
    karma_events.negative.sum(:points)
  end

  def positive_karma
    karma_events.positive.sum(:points)
  end

  def above_virtue_threshold?
    karma > VIRTUE_THRESHOLD
  end

  def above_vice_threshold?
    karma > VICE_THRESHOLD
  end
end
