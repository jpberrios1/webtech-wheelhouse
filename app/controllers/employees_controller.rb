class EmployeesController < ApplicationController

    def index
        @employees = Employee.order(:role)
    end

    def show
        @employee = Employee.find(params[:id])
    end



end