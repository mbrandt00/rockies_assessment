class Pitch < ApplicationRecord
    belongs_to :pitcher
    belongs_to :game
end