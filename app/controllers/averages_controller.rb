class AveragesController < ApplicationController 
    def index 
        if params[:type].present? 
            @type = params[:type]
            @averages = params[:name].present? ? Pitcher.averages(params[:type]).search(params[:name]) : Pitcher.averages(params[:type])
        else 
            # default type
            @type = 'Changeup'
            @averages = params[:name].present? ? Pitcher.averages('Changeup').search(params[:name]) : Pitcher.averages('Changeup')
        end  
    end

    def change_pitch_type 
        redirect_to :action => :index, type: params[:type], name: params[:name]
    end

    def show 
        @pitcher = Pitcher.find(params[:id])
    end
end