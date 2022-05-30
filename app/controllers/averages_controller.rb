class AveragesController < ApplicationController 
    def index 
        @averages = Pitcher.averages('Sinker')
    end
end