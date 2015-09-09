require 'rails_helper'

describe "Employee pages" do
  describe "index page", type: :feature do
    let!(:employees) { Fabricate.times 5, :employee }

    it "containe employees" do
      visit employees_path
      employees.each do |employee|
        expect(page).to have_content(employee.name)
      end
    end

    describe "click to Add new" do
      it "show page for creating new employee" do
        visit employees_path
        click_on("Add new")
        expect(current_path).to eq(new_employee_path)
      end
    end
  end

  describe "add new employee page", type: :feature do
    context "with correct fields filled" do
      describe "click to create employee" do
        let!(:employee_params) { Fabricate.attributes_for(:employee) }

        it "redirect to show page" do
          visit new_employee_path

          within("#new_employee") do
            fill_in 'employee[name]', with: employee_params[:name]
            fill_in 'employee[salary]', with: employee_params[:salary]
            select(employee_params[:status], :from => 'Status')
            fill_in 'employee[contacts]', with: employee_params[:contacts]
          end

          click_on 'Create'
          expect(current_path).to match(/\/employees\/(\d)+/)
        end
      end
    end

    context "with incorrect fields filled" do
      describe "click to create employee" do
        let!(:employee_params) { Fabricate.attributes_for(:employee) }

        it "show errors" do
          visit new_employee_path

          within("#new_employee") do
            fill_in 'employee[salary]', with: employee_params[:salary]
            select(employee_params[:status], :from => 'Status')
            fill_in 'employee[contacts]', with: employee_params[:contacts]
          end

          click_on 'Create'
          expect(page).to have_content("Name should contain 3 сyrillic words")
        end
      end
    end
  end
end