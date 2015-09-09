class Job < ActiveRecord::Base
  MATCH_LIMIT = 10
  has_many :skill_links, as: :skillable
  has_many :skills, through: :skill_links

  validates :title,      presence: true
  validates :contacts,   presence: true
  validates :expired_at, presence: true
  validates :salary,     presence: true, numericality: true

  scope :only_actual, -> {
    where(%("jobs"."expired_at" > ?), Time.current)
  }

  def exact_match_employees
    return [] if skill_ids.blank?
    suitable_employees.having(%q(COUNT("skill_links"."skill_id") = ?), skill_ids.count)
  end

  def partial_match_employees
    return [] if skill_ids.blank?
    suitable_employees.having(%q(COUNT("skill_links"."skill_id") > 0))
  end

  private

  def suitable_employees
    Employee.select(%q(DISTINCT("employees".*)))
      .joins(:skill_links)
      .only_looking
      .with_skill_ids(skill_ids)
      .group(%q("employees"."id"))
      .order(%q("employees"."salary" ASC))
      .limit(MATCH_LIMIT)
  end
end
