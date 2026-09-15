class StandardServicesController < ApplicationController

    def index
        @standard_services = StandardService.order(:current_price)
    end

    def show
        @standard_service = StandardService.find(params[:id])
    end

end