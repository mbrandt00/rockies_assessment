require 'rails_helper'

RSpec.describe Game do 
    describe 'relationships' do 
        it { should have_many(:pitches) }
    end
    describe 'instance methods' do 
        it '#event_description_count' do 
            game_1 = Game.create(home_team: 'Rockies', away_team: 'Dodgers', venue_name: 'Coors')
            game_2 = Game.create(home_team: 'Rockies', away_team: 'Diamondbacks', venue_name: 'Coors')
            pitcher_1 = Pitcher.create(pitcher_name: 'pitcher_1')
            pitcher_2 = Pitcher.create(pitcher_name: 'pitcher_2')
            pitch_1 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_1.id, play_event_description: "Walk", at_bat_inning: "01")
            pitch_2 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_1.id, play_event_description: "Strikeout", at_bat_inning: "02")
            pitch_3 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_1.id, play_event_description: "Walk", at_bat_inning: "03")
            pitch_4 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_2.id, play_event_description: "Pop Out", at_bat_inning: "04")
            expect(game_1.event_description_count(pitcher_1)).to eq({"Walk"=>2, "Strikeout"=>1})
            expect(game_1.event_description_count(pitcher_2)).to eq({"Pop Out"=>1})
        end
    end
end