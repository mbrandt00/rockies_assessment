class Pitcher < ApplicationRecord
    has_many :games 
    has_many :pitches

    def self.averages(pitch_type)
        joins(:pitches).
        group(:id).
        where(pitches: {pitch_type_description: pitch_type}).select('pitchers.*, AVG(pitches.release_speed) as release_speed, AVG(pitches.release_extension) as  release_extension, count(*) as total_pitches, sum(strike) as strikes, sum(ball) as balls, sum(in_play) as in_play')
    end
end