class KarmaEvent < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :points, presence: true

  scope :positive, -> { where(positive: true) }
  scope :negative, -> { where(positive: false) }

  def points=(points)
    self.positive = points >= 0
    super
  end
end
