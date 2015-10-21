class Champion < ActiveRecord::Base
  belongs_to :user

  validates :phone_number, :name, :user_id, presence: true

  def phone_number=(phone_number)
    write_attribute(:phone_number, PhoneNumber.new(phone_number).to_s)
  end
end
