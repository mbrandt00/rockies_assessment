class AveragesController < ApplicationController 
    def index 
        if params[:type].present? 
            @type = params[:type]
            if params[:name].present?
                @averages = Pitcher.averages(params[:type]).search(params[:name])
            else 
                @averages = Pitcher.averages(params[:type])
            end
        else 
            @averages = Pitcher.averages('Changeup')
            @type = 'Changeup'
        end  
    end

    def change_pitch_type 
        redirect_to :action => :index, type: params[:type], name: params[:name]
    end

    def show 
        @pitcher = Pitcher.find(params[:id])
    end
end