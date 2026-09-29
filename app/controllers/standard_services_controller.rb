class StandardServicesController < ApplicationController

    before_action :set_service, only: %i[show edit update destroy]

    def index
        @standard_services = StandardService.by_price
    end

    def show
    end

    def new 
        @standard_service = StandardService.new
    end

    def edit
    end

    def create
        @standard_service = StandardService.new(service_params)

        if @standard_service.save
            redirect_to @standard_service, notice: "Service #{@standard_service.name} was successfully created"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if @standard_service.update(service_params)
            redirect_to @standard_service, notice: "Service #{@standard_service.name} was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @standard_service.destroy
            redirect_to standard_services_path, notice: "Service #{@standard_service.name} was successfully deleted", status: :see_other
        else
            redirect_to @standard_service, alert: @standard_service.errors.full_messages.to_sentence
        end
    end

    private

    def set_service
        @standard_service = StandardService.find(params[:id])
    end

    def service_params
        params.expect(standard_service: [:name, :current_price])
    end

end