class BikesController < ApplicationController

    before_action :set_bike, only: %i[edit update destroy]


    def index
        @bikes = Bike.includes(:customer, :bike_model).by_serial
    end

    def show
        @bike = Bike.includes(:bike_model, :customer, repairs: :mechanic).find(params[:id])
    end

    def new 
        @bike = Bike.new(customer_id: params[:customer_id])
    end

    def edit
    end

    def create
        @bike = Bike.new(bike_params)

        if @bike.save
            redirect_to @bike, notice: "Bike #{@bike.serial_number} was successfully created."
        else
            render :new, status: :unprocessable_entity
        end

    end

    def update
        if @bike.update(bike_params)
            redirect_to @bike, notice: "Bike #{@bike.serial_number} was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @bike.destroy
            redirect_to bikes_path, notice: "Bike #{@bike.serial_number} was successfully deleted", status: :see_other
        else
            redirect_to @bike, alert: @bike.errors.full_messages.to_sentence
        end
    end

    private

    def set_bike
        @bike = Bike.find(params[:id])
    end

    def bike_params
        params.expect(bike: [:customer_id, :bike_model_id, :serial_number])
    end



end