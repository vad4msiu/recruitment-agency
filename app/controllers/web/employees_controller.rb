class Web::EmployeesController < Web::BaseController
  def index
    @employees = Employee.includes(:skills).page(params[:page])
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def create
    service = CreateEmployeeService.new(employee_params)
    service.perform
    @employee = service.employee

    respond_with @employee
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :salary, :status, :contacts, skill_titles: [])
  end
end