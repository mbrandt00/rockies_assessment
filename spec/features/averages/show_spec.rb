require 'rails_helper'

RSpec.describe 'Averages show' do 
    before :each do 
        @pitcher = Pitcher.create!(pitcher_name: 'Pujols, Albert')
        @game_1 = Game.create!(home_team: 'Angels', away_team: 'Rockies', venue_name: 'Angel Stadium', time: Time.now)
        # first at bat
        @pitch_2 = Pitch.create(pitch_type_description: "Slider", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 83.2, release_extension: 5.3, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 1, in_play: 0, play_event_description: "Single", at_bat_inning: "01")
        @pitch_3 = Pitch.create(pitch_type_description: "Slider", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 88.1, release_extension: 4.2, trajectory_vertical_break: -34.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 1, in_play: 0, play_event_description: "Single", at_bat_inning: "01")
        @pitch_3 = Pitch.create(pitch_type_description: "Curveball", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 90.0, release_extension: 4.0, trajectory_vertical_break: -29.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 1, in_play: 0, play_event_description: "Single", at_bat_inning: "01")
        @pitch_4 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 95.32, release_extension: 5.0, trajectory_vertical_break: -31.2608, trajectory_zone_speed: 84.8474, strike: 1, ball: 0, in_play: 0, play_event_description: "Walk", at_bat_inning: "01")
        @pitch_5 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 91, release_extension: 6.5, trajectory_vertical_break: -32.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 1, in_play: 0, play_event_description: "Walk", at_bat_inning: "01")
        # second at bat
        @pitch_6 = Pitch.create(pitch_type_description: "Slider", game_id: @game_1.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 74.2, release_extension: 6.2, trajectory_vertical_break: -34.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 0, in_play: 1, play_event_description: "Homerun", at_bat_inning: "02")
        # Second game 
        @game_2 = Game.create!(home_team: 'Angels', away_team: 'Rockies', venue_name: 'Angel Stadium', time: 1.day.ago)
        @pitch_7 = Pitch.create(pitch_type_description: "Slider", game_id: @game_2.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 83.2, release_extension: 5.3, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 0, in_play: 1, play_event_description: "Strikeout", at_bat_inning: "01")
        @pitch_8 = Pitch.create(pitch_type_description: "Slider", game_id: @game_2.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 88.1, release_extension: 4.2, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 0, in_play: 1, play_event_description: "Strikeout", at_bat_inning: "01")
        @pitch_9 = Pitch.create(pitch_type_description: "Curveball", game_id: @game_2.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 90.0, release_extension: 4.0, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 0, in_play: 1, play_event_description: "Strikeout", at_bat_inning: "01")
        @pitch_10 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_2.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 95.32, release_extension: 5.0, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 1, ball: 0, in_play: 0, play_event_description: "Single", at_bat_inning: "02")
        @pitch_11 = Pitch.create(pitch_type_description: "Four-Seam Fastball", game_id: @game_2.id, pitcher_id: @pitcher.id, pitch_hand: "Right", batter: "Hampson, Garrett", bat_side: "Right", call_description: "Ball", release_angle: -0.5522, release_speed: 91, release_extension: 6.5, trajectory_vertical_break: -30.2608, trajectory_zone_speed: 84.8474, strike: 0, ball: 0, in_play: 1, play_event_description: "Single", at_bat_inning: "02")
        # second at bat
        
        

    end
    it 'will show the pitchers averages for all the pitches' do 
        visit(average_path(@pitcher))
        expect(page).to have_css('table', text: 'Curveball')
        expect(page).to have_css('table', text: 'Slider')
        expect(page).to have_css('table', text: 'Four-Seam Fastball')
    end
    it 'will have game level information' do 
        visit(average_path(@pitcher))
        within "##{@game_1.id}" do 
            expect(page).to have_content('Angels vs. Rockies on May 31, 2022 @ Angel Stadium')
            expect(page).to have_content('Strikes: 1')
            expect(page).to have_content('Balls: 4')
            expect(page).to have_content('Homerun(s): 1')
        end
        within "##{@game_2.id}" do 
            expect(page).to have_content('Angels vs. Rockies on May 30, 2022 @ Angel Stadium')
            expect(page).to have_content('Strikeout(s): 1')
        end
    end
end