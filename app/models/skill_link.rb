class SkillLink < ActiveRecord::Base
  AVAILABLE_SKILLABLE_TYPES = ["Employee", "Job"]

  belongs_to :skillable, polymorphic: true
  belongs_to :skill

  validates :skillable, :skill, presence: true
  validates :skill_id, uniqueness: { scope: [:skillable_type, :skillable_id] }
  validates :skillable_type, inclusion: { in: AVAILABLE_SKILLABLE_TYPES }
end
