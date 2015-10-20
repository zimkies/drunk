class Champion < ActiveRecord::Base
  belongs_to :user

  validates :phone_number, :name, :user_id, presence: true
end
