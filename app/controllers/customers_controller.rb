class CustomersController < ApplicationController

    before_action :set_customer, only: %i[edit update destroy]
    before_action :authorize_staff, except: %i[index show]

    def index
        @customers = Customer.by_name
    end

    def show
        @customer = Customer.includes(bikes: { repairs: :mechanic}).find(params[:id])
    end

    def new
        @customer = Customer.new
    end

    def edit
    end

    def create
        @customer = Customer.new(customer_params)

        if @customer.save
            redirect_to @customer, notice: "Customer #{@customer.name} was successfully created."
        else
            render :new, status: :unprocessable_entity
        end

    end

    def update
        if @customer.update(customer_params)
            redirect_to @customer, notice: "Customer #{@customer.name} was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if @customer.destroy
            redirect_to customers_path, notice: "Customer #{@customer.name} was successfully deleted", status: :see_other
        else
            redirect_to @customer, alert: @customer.errors.full_messages.to_sentence
        end
    end

    private

    def set_customer
        @customer = Customer.find(params[:id])
    end

    def customer_params
        params.expect(customer: [:name, :phone, :is_regular])
    end

    def authorize_staff
        unless Current.user.role.in?(["owner", "counter"])
            redirect_to customers_path, alert: "Mechanics are not authorized to modify customers."
        end
  end

end
