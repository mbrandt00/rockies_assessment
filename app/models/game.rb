class Game < ApplicationRecord 
    has_many :pitches 
    def event_description_count(pitcher)
        outcomes = []
        pitches.where(pitcher: pitcher).group_by {|x| x.at_bat_inning}.each do |k,v|
            outcomes << v.first.play_event_description
        end
        return outcomes.tally
    end
end