require 'rails_helper'

describe "Job pages" do
  describe "index page", type: :feature do
    let!(:jobs) { Fabricate.times 5, :job }

    it "contain jobs" do
      visit jobs_path
      jobs.each do |job|
        expect(page).to have_content(job.title)
      end
    end

    describe "click to Add new" do
      it "show page for creating new job" do
        visit jobs_path
        click_on("Add new")
        expect(current_path).to eq(new_job_path)
      end
    end
  end

  describe "add new job page", type: :feature do
    context "with correct fields filled" do
      describe "click to create job" do
        let!(:job_params) { Fabricate.attributes_for(:job) }

        it "redirect to show page" do
          visit new_job_path

          within("#new_job") do
            fill_in 'job[title]', with: job_params[:title]
            fill_in 'job[salary]', with: job_params[:salary]
            fill_in 'job[expired_at]', with: job_params[:expired_at]
            fill_in 'job[contacts]', with: job_params[:contacts]
          end

          click_on 'Create'
          expect(current_path).to match(/\/jobs\/(\d)+/)
        end
      end
    end

    context "with incorrect fields filled" do
      describe "click to create job" do
        let!(:job_params) { Fabricate.attributes_for(:job) }

        it "show errors" do
          visit new_job_path

          within("#new_job") do
            fill_in 'job[salary]', with: job_params[:salary]
            fill_in 'job[expired_at]', with: job_params[:expired_at]
            fill_in 'job[contacts]', with: job_params[:contacts]
          end

          click_on 'Create'
          expect(page).to have_content("Title can't be blank")
        end
      end
    end
  end
end