class CreateKarmaEvents < ActiveRecord::Migration
  def change
    create_table :karma_events do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :points, null: false
      t.boolean :positive, null: false

      t.timestamps null: false
    end
  end
end
