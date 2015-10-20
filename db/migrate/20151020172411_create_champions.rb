class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string :name
      t.string :phone_number
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
