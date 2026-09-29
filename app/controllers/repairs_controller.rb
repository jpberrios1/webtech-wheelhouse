class RepairsController < ApplicationController

    before_action :set_repair, only: %i[edit update destroy]

    def index
        @repairs = Repair.includes(:mechanic, bike: [:customer, :bike_model]).newest_first
    end

    def show
        @repair = Repair.includes(:mechanic, bike: [:customer, :bike_model], repair_services: :standard_service).find(params[:id])
    end

    def new
        @repair = Repair.new(bike_id: params[:bike_id])
        3.times { @repair.repair_services.build }
    end

    def edit
    end

    def create
        @repair = Repair.new(repair_params)

        if @repair.save
            redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if @repair.update(repair_params)
            redirect_to @repair, notice: "Repair for bike #{@repair.bike.serial_number} was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @repair.destroy
            redirect_to repairs_path, notice: "Repair for bike #{@repair.bike.serial_number} was successfully deleted", status: :see_other
        else
            redirect_to @repair, alert: @repair.errors.full_messages.to_sentence
        end
    end

    private

    def set_repair
        @repair = Repair.find(params[:id])
    end

    def repair_params
        params.require(:repair).permit(:bike_id, :mechanic_id, :state, :is_approved, :promised_on, :handed_back_at,
         repair_services_attributes: [:id, :standard_service_id, :charged_price, :_destroy])
    end

end