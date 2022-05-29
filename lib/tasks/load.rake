require 'csv'

desc 'Import Pitches' 
task :pitches, [:filename] => :environment do
    t1 = Time.now
    CSV.foreach('./rockies_full_stack_developer_project_data.csv', headers: true) do |row|
        game_info = row.to_h
        # create/find pitcher
        pitcher = Pitcher.where(pitcher_name: pitcher).empty? ? Pitcher.create!(pitcher_name: game_info['pitcher_name']) : Pitcher.where(pitcher_name: game_info['pitcher_name']).first
        # find/create game from task above
        game_id = game_info['game_pk'].to_i
        if Game.where(game_id: game_id).empty?
            time = game_info['game_datetime'].to_datetime
            home_team = game_info['home_team_name']
            away_team = game_info['away_team_name']
            venue_name = game_info['venue_name']
            game = Game.create!(time: time, home_team: home_team, away_team: away_team, venue_name: venue_name, game_id: game_id)
        else 
            game = Game.where(game_id: game_info['game_pk']).first
        end
        # create pitch
        pitch_type_description = game_info['pitch_type_description']
        pitch_hand = game_info['pitch_hand']
        batter = game_info['batter_name']
        bat_side = game_info['bat_side']
        call_description = game_info['call_description']
        release_angle = game_info['pitch_release_angle'].to_f.round(4)
        release_speed = game_info['pitch_release_angle'].to_f.round(4)
        release_extension = game_info['pitch_release_extension'].to_f.round(4)
        trajectory_vertical_break = game_info['pitch_trajectory_vertical_break'].to_f.round(4)
        trajectory_zone_speed = game_info['pitch_trajectory_zone_speed'].to_f.round(4)
        a = Pitch.create!(game_id: game.id, pitcher_id: pitcher.id, pitch_type_description: pitch_type_description, pitch_hand: pitch_hand, batter: batter, bat_side: bat_side, call_description: call_description, release_angle: release_angle, release_speed: release_speed, release_extension: release_extension, trajectory_vertical_break: trajectory_vertical_break, trajectory_zone_speed: trajectory_zone_speed)
    end
    t2 = Time.now
    p(t2 - t1) # in seconds
end