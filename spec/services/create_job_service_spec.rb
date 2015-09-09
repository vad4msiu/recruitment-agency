require 'rails_helper'

describe CreateJobService do
  describe "perform" do
    subject { CreateJobService.new(job_params) }

    before { subject.perform }

    context "with correct job params" do
      let!(:skill_titles) {
        3.times.map {
          Fabricate.attributes_for(:skill)[:title]
        }
      }
      let!(:job_params) {
        Fabricate.attributes_for(:job).merge(skill_titles: skill_titles)
      }

      it "create job" do
        expect(subject.job).to_not be_new_record
      end

      it "link skills with job" do
        linked_skill_title = subject.job.skills.pluck(:title)
        expect(linked_skill_title.sort).to eq(skill_titles.sort)
      end
    end

    context "with incorrect job params" do
      let!(:job_params) {
        Fabricate.attributes_for(:job).except(:title)
      }

      it "doesn't create job" do
        expect(subject.job).to be_new_record
      end

      it "provides access to job errors" do
        expect(subject.job.errors).to be_present
      end
    end
  end
end