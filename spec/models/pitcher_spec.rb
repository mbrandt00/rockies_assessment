require 'rails_helper'

RSpec.describe Pitcher do 
    describe 'relationships' do 
        it { should have_many(:pitches) }
        it { should have_many(:games).through(:pitches) }
    end
    describe 'class methods' do 
        it '.averages' do 
            rockies = Team.create(team_name: 'Colorado Rockies')
            game_1 = Game.create(home_team: 'Rockies', away_team: 'Dodgers', venue_name: 'Coors')
            game_2 = Game.create(home_team: 'Rockies', away_team: 'Diamondbacks', venue_name: 'Coors')
            pitcher_1 = Pitcher.create(pitcher_name: 'pitcher_1', team: rockies)
            pitcher_2 = Pitcher.create(pitcher_name: 'pitcher_2', team: rockies)
            pitch_1 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_1.id, play_event_description: "Walk", at_bat_inning: "01", release_extension: 5, release_speed: 90.0, strike: 1)
            pitch_2 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_1.id, play_event_description: "Strikeout", at_bat_inning: "02", release_extension: 3, release_speed: 98.0, ball: 1)
            pitch_3 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_2.id, play_event_description: "Walk", at_bat_inning: "03", release_extension: 1, release_speed: 40.0, strike: 2)
            pitch_4 = Pitch.create(pitch_type_description: "Sinker", game_id: game_1.id, pitcher_id: pitcher_2.id, play_event_description: "Pop Out", at_bat_inning: "04", release_extension: 3, release_speed: 90.0, strike: 2)
            averages = Pitcher.averages('Sinker')
            expect(averages.first.release_speed).to eq(94.0)
            expect(averages.first.release_speed).to eq(94.0)
            expect(averages.first.strikes).to eq(1)
            expect(averages.first.balls).to eq(1)
            expect(averages.first.total_pitches).to eq(2)
            expect(averages.second.release_speed).to eq(65.0)
        end
        it '.search' do 
            rockies = Team.create(team_name: 'Colorado Rockies')
            pitcher_1 = Pitcher.create!(pitcher_name: 'Smith, Joe', team: rockies)
            pitcher_2 = Pitcher.create!(pitcher_name: 'Daniel, Joe', team: rockies)
            pitcher_3 = Pitcher.create!(pitcher_name: 'Sam, Hernandez', team: rockies)
            pitcher_4 = Pitcher.create!(pitcher_name: 'Alex, Hernando', team: rockies)
            expect(Pitcher.search('Joe')).to eq([pitcher_1, pitcher_2])
            expect(Pitcher.search('jo')).to eq([pitcher_1, pitcher_2])
            expect(Pitcher.search('asdf')).to eq([])
            expect(Pitcher.search('Hern')).to eq([pitcher_3, pitcher_4])
        end
    end 
    describe 'instance methods' do 
        before :each do 
            @rockies = Team.create(team_name: 'Colorado Rockies')
            @game_1 = Game.create(home_team: 'Rockies', away_team: 'Dodgers', venue_name: 'Coors')
            @game_2 = Game.create(home_team: 'Rockies', away_team: 'Giants', venue_name: 'Coors')
            @pitcher_1 = Pitcher.create(pitcher_name: 'pitcher_1', team: @rockies)
            @pitch_1 = Pitch.create(pitch_type_description: "Fastball", game_id: @game_1.id, pitcher_id: @pitcher_1.id, play_event_description: "Walk", at_bat_inning: "01", release_extension: 5, release_speed: 100.0, strike: 1)
            @pitch_2 = Pitch.create(pitch_type_description: "Curveball", game_id: @game_1.id, pitcher_id: @pitcher_1.id, play_event_description: "Strikeout", at_bat_inning: "02", release_extension: 3, release_speed: 40.0, ball: 1)
            @pitch_3 = Pitch.create(pitch_type_description: "Curveball", game_id: @game_1.id, pitcher_id: @pitcher_1.id, play_event_description: "Strikeout", at_bat_inning: "02", release_extension: 3, release_speed: 50.0, ball: 1)
            @pitch_4 = Pitch.create(pitch_type_description: "Curveball", game_id: @game_2.id, pitcher_id: @pitcher_1.id, play_event_description: "Strikeout", at_bat_inning: "02", release_extension: 3, release_speed: 50.0, ball: 1)
        end
        it '#pitch_type_average' do 
            @pitcher_1.pitch_type_average.each do |pitch| 
                expect(pitch.pitch_type).to be_a(String)
                expect(pitch.release_speed).to be_a(Float)
                expect(pitch.release_extension).to be_a(Float)
                expect(pitch.total_pitches).to be_a(Integer)
            end
            expect(@pitcher_1.pitch_type_average.length).to eq(2)
        end
        it '#stats_by_game' do 
            expect(@pitcher_1.stats_by_game.first.total_pitches).to eq(3)
            expect(@pitcher_1.stats_by_game.second.total_pitches).to eq(1)
        end
    end
end