class AddLastKarmaRemindedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_karma_reminded_at, :datetime
  end
end
