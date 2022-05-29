class Pitcher < ApplicationRecord
    has_many :games 
    has_many :pitches
end