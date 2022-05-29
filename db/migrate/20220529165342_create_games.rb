class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.datetime :time
      t.string :home_team
      t.string :away_team
      t.string :venue_name
      t.integer :game_id
    end
  end
end
