class Skill < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  scope :with_titles, ->(titles) { where(title: titles) }
  scope :search, ->(query) {
    where(%q("skills"."title" ILIKE ?), "#{sanitize_sql_like(query)}%" )
  }
end
