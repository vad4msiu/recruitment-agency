require 'rails_helper'

describe Employee do
  let!(:jobs) { Fabricate.times 10, :job, expired_at: Time.current + 1.day }
  let!(:employee) {
    empl = Fabricate :employee
    skills = Fabricate.times 10, :skill
    empl.update(skills: skills)
    empl
  }

  describe "#partial_match_jobs" do
    context "with partial match skills" do
      let!(:suitable_jobs) {
        jobs.sample(5).map do |job|
          skills = Fabricate.times 3, :skill
          job.update(skills: employee.skills - employee.skills.sample(1) + skills)
          job
        end
      }

      it "find suitable jobs" do
        expect(employee.partial_match_jobs.sort).to eq(suitable_jobs.sort)
      end
    end

    context "without partial match skills" do
      let!(:suitable_jobs) {
        jobs.sample(5).map do |job|
          skills = Fabricate.times 3, :skill
          job.update(skills: skills)
          job
        end
      }

      it "doesn't find suitable jobs" do
        expect(employee.partial_match_jobs).to be_empty
      end
    end
  end

  describe "#exact_match_jobs" do
    context "with exact match skills" do
      let!(:suitable_jobs) {
        jobs.sample(5).map do |job|
          job.update(skills: employee.skills.sample(5))
          job
        end
      }

      it "find suitable jobs" do
        expect(employee.exact_match_jobs.sort).to eq(suitable_jobs.sort)
      end
    end

    context "without exact match skills" do
      before do
        jobs.sample(5).each do |job|
          skills = Fabricate.times 3, :skill
          job.update(skills: employee.skills.sample(5) + skills)
        end
      end

      it "doesn't find suitable jobs" do
        expect(employee.exact_match_jobs).to be_empty
      end
    end
  end
end