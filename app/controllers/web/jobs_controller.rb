class Web::JobsController < Web::BaseController
  def index
    @jobs = Job.includes(:skills).page(params[:page])
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    service = CreateJobService.new(job_params)
    service.perform
    @job = service.job

    respond_with @job
  end

  private

  def job_params
    params.require(:job).permit(:title, :salary, :expired_at, :contacts, skill_titles: [])
  end
end