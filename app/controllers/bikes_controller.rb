class BikesController < ApplicationController
    def index
        @bikes = Bike.order(created_at: :desc)
    end

    def show
        @bike = Bike.find(params[:id])
    end



end