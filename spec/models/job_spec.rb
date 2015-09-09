require 'rails_helper'

describe Job do
  let!(:employees) { Fabricate.times 10, :employee, status: Employee::LOOKING_STATUS }
  let!(:job) {
    j = Fabricate :job
    skills = Fabricate.times 3, :skill
    j.update(skills: skills)
    j
  }

  describe "#partial_match_employees" do
    context "with partial match skills" do
      let!(:suitable_employees) {
        employees.sample(5).map do |employee|
          skills = Fabricate.times 3, :skill
          employee.update(skills: job.skills - job.skills.sample(1) + skills)
          employee
        end
      }

      it "find suitable employees" do
        expect(job.partial_match_employees.sort).to eq(suitable_employees.sort)
      end
    end

    context "without partial match skills" do
      let!(:suitable_employees) {
        employees.sample(5).map do |employee|
          skills = Fabricate.times 3, :skill
          employee.update(skills: skills)
          employee
        end
      }

      it "doesn't find suitable employees" do
        expect(job.partial_match_employees).to be_empty
      end
    end
  end

  describe "#exact_match_employees" do
    context "with exact match skills" do
      let!(:suitable_employees) {
        employees.sample(5).map do |employee|
          skills = Fabricate.times 3, :skill
          employee.update(skills: skills + job.skills)
          employee
        end
      }

      it "find suitable employees" do
        expect(job.exact_match_employees.sort).to eq(suitable_employees.sort)
      end
    end

    context "without exact match skills" do
      before do
        employees.sample(5).map do |employee|
          skills = Fabricate.times 3, :skill
          employee.update(skills: skills)
          employee
        end
      end

      it "doesn't find suitable employees" do
        expect(job.exact_match_employees).to be_empty
      end
    end
  end
end