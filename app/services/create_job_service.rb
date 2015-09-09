class CreateJobService
  attr_reader :params, :skill_titles, :job

  def initialize(params)
    @params       = params
    @skill_titles = params.delete(:skill_titles) || []
  end

  def perform
    Job.transaction do
      @job = Job.new(params)

      if @job.save
        service = CreateMissingSkillsService.new(skill_titles)
        service.perform!
        @job.update(skills: service.skills)
      end
    end
  end
end