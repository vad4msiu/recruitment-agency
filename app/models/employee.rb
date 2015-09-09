class Employee < ActiveRecord::Base
  MATCH_LIMIT = 10
  AVAILABLE_STATUSES = [
    LOOKING_STATUS     = "looking",
    NOT_LOOKING_STATUS = "not_looking"
  ]

  has_many :skill_links, as: :skillable
  has_many :skills, through: :skill_links

  validates :name, presence: true, format: {
    with: /\A\s*[а-я]+\s+[а-я]+\s+[а-я]+\s*\z/im,
    message: "should contain 3 сyrillic words"
  }
  validates :contacts, presence: true, format: {
    with: /(@|[[:digit:]]+)/i,
    message: "should contain email or telephone number"
  }
  validates :salary, presence: true, numericality: true
  validates :status, presence: true, inclusion: { in: AVAILABLE_STATUSES }

  scope :only_looking, -> {
    where(status: LOOKING_STATUS)
  }
  scope :with_skill_ids, ->(skill_ids) {
    joins(:skill_links).where(skill_links: { skill_id: skill_ids })
  }

  def exact_match_jobs
    return [] if skill_ids.blank?
    suitable_jobs.having(
      %q(
        ICOUNT(
          ARRAY_AGG("skill_links"."skill_id") & ARRAY[?]
        ) = ICOUNT(
          ARRAY_AGG("skill_links"."skill_id")
        )
      ), skill_ids
    )
  end

  def partial_match_jobs
    return [] if skill_ids.blank?
    suitable_jobs.having(
      %q(
        ICOUNT(ARRAY_AGG("skill_links"."skill_id") & ARRAY[?]) > 0
      ), skill_ids
    )
  end

  private

  def suitable_jobs
    Job.select(%q(DISTINCT("jobs".*)))
      .joins(:skill_links)
      .only_actual
      .group(%q("jobs"."id"))
      .order(%q("jobs"."salary" DESC))
      .limit(MATCH_LIMIT)
  end
end
