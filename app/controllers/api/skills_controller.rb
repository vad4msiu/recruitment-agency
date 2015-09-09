class Api::SkillsController < Api::BaseController
  def search
    @skills = Skill.search(params[:term]).limit(10).pluck(:title)

    respond_with @skills
  end
end