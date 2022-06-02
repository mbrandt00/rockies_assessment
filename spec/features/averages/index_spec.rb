require 'rails_helper'

RSpec.describe 'Averages Index' do 
    before :each do 
        @game_1 = Game.create(home_team: 'Rockies', away_team: 'Dodgers', venue_name: 'Coors', time: Time.now)
        @game_2 = Game.create(home_team: 'Rockies', away_team: 'Giants', venue_name: 'Coors', time: Time.now)
        rockies = Team.create(team_name: 'Colorado Rockies')
        @pitcher_1 = Pitcher.create(pitcher_name: 'pitcher_1', team: rockies)
        @pitcher_2 = Pitcher.create(pitcher_name: 'pitcher_2', team: rockies)
        @pitch_1 = Pitch.create(pitch_type_description: "Changeup", game_id: @game_1.id, pitcher_id: @pitcher_1.id, strike: 1, at_bat_inning: "01", release_extension: 5, release_speed: 100.0)
        @pitch_2 = Pitch.create(pitch_type_description: "Changeup", game_id: @game_1.id, pitcher_id: @pitcher_1.id, strike: 1, at_bat_inning: "02", release_extension: 3, release_speed: 40.0, ball: 1)
        @pitch_3 = Pitch.create(pitch_type_description: "Changeup", game_id: @game_1.id, pitcher_id: @pitcher_1.id, ball: 1, at_bat_inning: "02", release_extension: 3, release_speed: 50.0)
        @pitch_4 = Pitch.create(pitch_type_description: "Changeup", game_id: @game_2.id, pitcher_id: @pitcher_2.id, strike: 1, at_bat_inning: "02", release_extension: 3, release_speed: 50.0, ball: 1)
        @pitch_5 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_2.id, pitcher_id: @pitcher_2.id, strike: 1, at_bat_inning: "02", release_extension: 3, release_speed: 100.0, ball: 1)
        @pitch_6 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_2.id, pitcher_id: @pitcher_1.id, strike: 1, at_bat_inning: "02", release_extension: 3, release_speed: 75.0, ball: 1)
    end
    it 'will have a table with averages of pitch stats by pitch type for each pitcher' do 
        visit(averages_path)
        expect(page).to have_css('table', text: '50.0')
    end
    it 'will change the type of pitch and show different values with name and type' do 
        visit(averages_path)
        choose(option: 'Four-Seam Fastball')
        fill_in('name', with: '2')
        click_button('Filter Pitches/Pitchers')
        expect(page).to have_css('table', text: '100.0')
    end
    it 'will sort by just type of pitch' do 
        visit(averages_path)
        choose(option: 'Four-Seam Fastball')
        click_button('Filter Pitches/Pitchers')
        expect(page).to have_css('table', text: '100.0')
        expect(page).to have_css('table', text: '75.0')
    end
    it 'will have a clickable name that will lead direct to the showpage' do 
        visit(averages_path)
        click_on('pitcher_1')
        expect(current_path).to eq(average_path(@pitcher_1))
    end
    
end