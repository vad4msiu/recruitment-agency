require 'rails_helper'

describe CreateEmployeeService do
  describe "perform" do
    subject { CreateEmployeeService.new(employee_params) }

    before { subject.perform }

    context "with correct employee params" do
      let!(:skill_titles) {
        3.times.map {
          Fabricate.attributes_for(:skill)[:title]
        }
      }
      let!(:employee_params) {
        Fabricate.attributes_for(:employee).merge(skill_titles: skill_titles)
      }

      it "create employee" do
        expect(subject.employee).to_not be_new_record
      end

      it "link skills with employee" do
        linked_skill_title = subject.employee.skills.pluck(:title)
        expect(linked_skill_title.sort).to eq(skill_titles.sort)
      end
    end

    context "with incorrect employee params" do
      let!(:employee_params) {
        Fabricate.attributes_for(:employee).except(:name)
      }

      it "doesn't create employee" do
        expect(subject.employee).to be_new_record
      end

      it "provides access to employee errors" do
        expect(subject.employee.errors).to be_present
      end
    end
  end
end