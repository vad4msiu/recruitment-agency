class CreateMissingSkillsService
  attr_reader :skill_titles, :skills

  def initialize(skill_titles)
    @skill_titles = Array(skill_titles)
  end

  def perform!
    missing_skill_titles.each do |skill_title|
      Skill.create!(title: skill_title)
    end
  end

  def skills
    Skill.with_titles(skill_titles)
  end

  private

  def exists_skill_titles
    Skill.with_titles(skill_titles).pluck(:title)
  end

  def missing_skill_titles
    skill_titles - exists_skill_titles
  end
end