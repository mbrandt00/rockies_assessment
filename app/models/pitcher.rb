class Pitcher < ApplicationRecord
    has_many :pitches
    has_many :games, through: :pitches
    belongs_to :team

    def self.averages(pitch_type = 'Changeup')
        joins(:pitches).
        group(:id).
        where(pitches: {pitch_type_description: pitch_type}).
        select('
                pitchers.*, 
                AVG(pitches.release_speed) as release_speed, 
                AVG(pitches.release_extension) as release_extension, 
                count(*) as total_pitches, 
                sum(strike) as strikes, 
                sum(ball) as balls, 
                sum(in_play) as in_play
            ')
    end

    def pitch_type_average
        pitches.
        group('pitches.pitch_type_description').
        select('
                pitches.pitch_type_description as pitch_type, 
                AVG(pitches.release_speed) as release_speed, 
                AVG(pitches.release_extension) as release_extension, 
                count(*) as total_pitches, 
                sum(strike) as strikes,    
                sum(ball) as balls,    
                sum(in_play) as in_play   
            ')
    end

    def stats_by_game
        games.
        group('games.id').
        select('
                games.*, 
                sum(strike) as strikes, 
                sum(ball) as balls, 
                sum(in_play) as in_play, 
                count(*) as total_pitches
            ').
        order('games.time DESC')
    end
    
    def self.search(name)
        where('pitcher_name ILIKE ?', "%#{name}%")
    end
    
end