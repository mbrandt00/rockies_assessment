class Team < ApplicationRecord 
    has_many :games
    has_many :pitchers
    has_many :pitches, through: :pitchers

    def self.summary_statistics 
        joins(pitchers: :pitches).
        group(:id).
        select('
                teams.* as team, 
                sum(pitches.strike) as strikes, 
                sum(pitches.ball) as balls, 
                count(*) as total_pitches
            ')
    end
    def highest_strike_percentage
        pitchers.joins(:pitches).group('pitchers.id').select('pitchers.* as pitcher, cast(sum(strike) as float)/count(*) as strike_percentage').order(strike_percentage: :desc).limit(5)
    end
    def highest_ball_percentage
        pitchers.joins(:pitches).group('pitchers.id').select('pitchers.* as pitcher, cast(sum(ball) as float)/count(*) as ball_percentage').order(ball_percentage: :desc).limit(5)
    end
    def fastest_pitchers
        pitchers.joins(:pitches).group('pitchers.id').where(pitches: {pitch_type_description: 'Four-Seam Fastball'}).select('pitchers.* as pitcher, AVG(release_speed) as speed').order(speed: :desc).limit(5)
    end
    def most_strikeouts
    end
end