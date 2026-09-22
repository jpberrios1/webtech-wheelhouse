class EmployeesController < ApplicationController

    def index
        @employees = Employee.by_name
    end

    def show
        @employee = Employee.find(params[:id])
    end



end