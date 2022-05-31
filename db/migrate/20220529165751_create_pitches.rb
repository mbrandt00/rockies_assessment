class CreatePitches < ActiveRecord::Migration[5.2]
  def change
    create_table :pitches do |t|
      t.string :pitch_type_description
      t.references :game, foreign_key: true
      t.references :pitcher, foreign_key: true
      t.string :pitch_hand
      t.string :batter
      t.string :bat_side
      t.string :call_description
      t.float :release_angle
      t.float :release_speed
      t.float :release_extension
      t.float :trajectory_vertical_break
      t.float :trajectory_zone_speed
      t.integer :strike
      t.integer :ball
      t.integer :in_play
      t.string :play_event_description
      t.string :at_bat_inning
    end
  end
end
