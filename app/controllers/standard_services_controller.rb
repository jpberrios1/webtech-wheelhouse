class StandardServicesController < ApplicationController

    before_action :set_service, only: %i[show edit update destroy]
    allow_unauthenticated_access only: %i[index show]

    skip_after_action :verify_authorized, only: :show

    def index
        @standard_services = policy_scope(StandardService).by_price
    end

    def show
    end

    def new 
        @standard_service = StandardService.new
        authorize @standard_service
    end

    def edit
        authorize @standard_service
    end

    def create
        @standard_service = StandardService.new(service_params)
        authorize @standard_service

        if @standard_service.save
            redirect_to @standard_service, notice: "Service #{@standard_service.name} was successfully created"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        authorize @standard_service

        if @standard_service.update(service_params)
            redirect_to @standard_service, notice: "Service #{@standard_service.name} was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        authorize @standard_service
        
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