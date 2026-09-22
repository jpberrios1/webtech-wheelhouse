class BikesController < ApplicationController
    def index
        @bikes = Bike.includes(:customer, :bike_model).by_serial
    end

    def show
        @bike = Bike.includes(:bike_model, :customer, repairs: :mechanic).find(params[:id])
    end



end