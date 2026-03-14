class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :nickname
      t.string :image

      t.references :team, null: true, foreign_key: true
      t.references :country, null: true, foreign_key: true

      t.timestamps
    end
  end
end
