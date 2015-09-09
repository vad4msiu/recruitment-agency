require 'rails_helper'

describe CreateMissingSkillsService do
  describe "perform!" do
    subject { CreateMissingSkillsService.new(skill_titles) }

    context "with correct skill titles" do
      let!(:skill_titles) {
        3.times.map {
          Fabricate.attributes_for(:skill)[:title]
        }
      }

      it "create skills" do
        subject.perform!
        expect(subject.skills).to_not be_any(&:new_record?)
      end
    end

    context "with incorrect employee params" do
      let!(:skill_titles) { [""] }

      it "doesn't create employee" do
        expect { subject.perform! }.to raise_error
      end
    end
  end
end