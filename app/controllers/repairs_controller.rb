class RepairsController < ApplicationController

    def index
        @repairs = Repair.includes(:mechanic, bike: [:customer, :bike_model]).newest_first
    end

    def show
        @repair = Repair.includes(:mechanic, bike: [:customer, :bike_model], repair_services: :standard_service).find(params[:id])
    end

end