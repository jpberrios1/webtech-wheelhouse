class Api::V1::ServicesController < Api::V1::BaseController

    before_action :require_api_token!, only: [:create]

    def index
        services = StandardService.includes(:repair_services).order(:name)
        render json: services.map { |service| service_document(service)}
    end

    def show
        service = StandardService.find(params[:id])
        render json: service_document(service)
    end

    def create
        if service_params.empty?
            raise ActionController::ParameterMissing.new(:service)
        end

        service = StandardService.new(service_params)

        if service.save
            render json: service_document(service), status: :created, location: api_v1_service_url(service)
        else
            render json: {errors: service.errors.full_messages}, status: :unprocessable_entity
        end
    end

    private

    def service_params
        params.expect(service: [:name, :current_price])
    end

    def service_document(service)
        {
            id: service.id,
            name: service.name, # Faltaba esta coma
            price: service.current_price.to_s,
            charged_on_repairs_count: service.repair_services.size
        }
    end

end