class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  def index
    authorize Employee
    @employees = policy_scope(Employee).by_name
  end

  def show
    authorize @employee
  end

  def new
    @employee = Employee.new
    authorize @employee
  end

  def edit
    authorize @employee
  end

  def create
    @employee = Employee.new(employee_params)
    authorize @employee

    if @employee.save
      redirect_to @employee, notice: "Employee #{@employee.name} was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @employee

    if @employee.update(employee_params)
      redirect_to @employee, notice: "Employee #{@employee.name} was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @employee

    if @employee.destroy
      redirect_to employees_path, notice: "Employee #{@employee.name} was successfully deleted", status: :see_other
    else
      redirect_to @employee, alert: @employee.errors.full_messages.to_sentence
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.expect(employee: %i[name role])
  end
end