class Api::V1::RepairsController < Api::V1::BaseController

    before_action :require_api_token!

    def index
        repairs = Repair.includes(bike: [:customer, :bike_model], repair_services: :standard_service).newest_first

        if params[:state].present?
            unless Repair.states.keys.include?(params[:state])
                return render json: {errors: ["Invalid state. Allowed states are: #{Repair.states.keys.join(', ')}"]}, status: :bad_request
            end

            repairs = repairs.where(state: params[:state])
        end

        render json: repairs.map { |repair| repair_document(repair)}
    end

    def show
        repair = Repair.includes(bike: [:customer, :bike_model], repair_services: :standard_service).find(params[:id])
        render json: repair_document(repair)
    end

    private

    def repair_document(repair)
        {
            id: repair.id,
            state: repair.state,
            came_in_on: repair.created_at.to_date,
            promised_on: repair.promised_on,
            handed_back_at: repair.handed_back_at,
            total: repair.total.to_s,
            overdue: repair.overdue?,
            customer_answer: format_answer(repair.is_approved),
            bike: {
                brand: repair.bike.bike_model.name, # This isn't necessary, but the instructions requiere it
                model: repair.bike.bike_model.name,
                serial_number: repair.bike.serial_number
            },
            customer: {
                name: repair.bike.customer.name
            },
            lines: repair.repair_services.map do |line|
                {
                    service: line.standard_service.name,
                    charged_price: line.charged_price.to_s
                }
            end
        }
    end

    def format_answer(is_approved)
        return "waiting" if is_approved.nil?
        is_approved ? "approved" : "declined"
    end

end