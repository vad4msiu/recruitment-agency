class CreateEmployeeService
  attr_reader :params, :skill_titles, :employee

  def initialize(params)
    @params       = params
    @skill_titles = params.delete(:skill_titles) || []
  end

  def perform
    Employee.transaction do
      @employee = Employee.new(params)

      if @employee.save
        service = CreateMissingSkillsService.new(skill_titles)
        service.perform!
        @employee.update(skills: service.skills)
      end
    end
  end

  private

  def skills
    Skill.with_titles(skill_titles)
  end

  def exists_skill_titles
    Skill.with_titles(skill_titles).pluck(:title)
  end

  def missing_skill_titles
    skill_titles - exists_skill_titles
  end

  def create_missing_skills
    missing_skill_titles.each do |skill_title|
      Skill.create!(title: skill_title)
    end
  end
end