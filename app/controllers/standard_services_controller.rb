class StandardServicesController < ApplicationController

    def index
        @standard_services = StandardService.by_price
    end

    def show
        @standard_service = StandardService.find(params[:id])
    end

end