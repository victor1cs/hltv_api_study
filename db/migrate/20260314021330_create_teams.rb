class CreateTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :ranking
      t.string :logo

      t.timestamps
    end
  end
end
