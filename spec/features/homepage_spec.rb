require 'rails_helper'
# require 'database_cleaner'
feature 'homepage' do 
  given!(:clinic) { FactoryGirl.create(:clinic) }

  context 'homepage' do 
    it 'should open page' do 
      visit root_path
      # save_and_open_page
    end
  end

  context 'homepage features' do
    it 'should click titlelink' do
      visit '/'
    end
  end

  context 'homepage hospitals' do 
    it 'should visit hospitals from root path' do 
      visit root_path
      click_link 'Hospitals'
      # save_and_open_page
    end

    it 'should fill in search bar' do
      visit clinics_path
      fill_in 'srch-term', with: 'clinic'
      click_button 'search'
      expect(page).to have_content('clinic')
    end
  end

  context 'homepage to prescriptions' do 
    it 'should visit prescriptions from root path' do 
      visit root_path
      click_link 'Prescriptions'
    end
  end

  context 'homepage' do
    it 'should be able to add a clinic' do
      visit clinics_path
      click_link 'New Clinic'
      fill_in 'Name', with: 'Clinic'
      fill_in 'Address', with: 'Address'
      fill_in 'City', with: 'City'
      select "GA", from: "State"
      fill_in 'Zip', with: 29464
      click_button 'Create Clinic'
      expect(page).to have_content('Clinic was successfully created')
      expect(page).not_to have_content('Welcome!')
      # save_and_open_page
    end
  end
end

feature 'clinic show' do
  given!(:clinic) { FactoryGirl.create(:clinic) }

  context 'going to a clinic' do
    it "should be able to go to a specific clinic" do
      visit clinics_path
      click_link 'clinic'
      # save_and_open_page
    end
  end
  
  context 'edit' do
    it 'should edit a clinic' do
      visit clinics_path
      click_link 'clinic'
      click_link 'Edit Clinic'
      fill_in 'Name', with: 'Clinic is awesome'
      fill_in 'Address', with: 'Address change'
      fill_in 'City', with: 'City is changed'
      select 'SC', from: 'State'
      fill_in 'Zip', with: 29401
      click_button 'Create Clinic'
      expect(page).to have_content('Clinic updated.')
      # save_and_open_page
    end
  end

  context 'delete clinic' do 
    it 'should delete a clinic' do
      visit clinics_path
      click_link 'clinic'
      click_link 'Delete Clinic'
      expect(page).to have_content('Clinic was successfully deleted.')
      # save_and_open_page
    end
  end

  context 'add prescription' do 
    it 'should add a prescription to a clinic' do
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Prescription'
      fill_in 'nameInput', with: 'name'
      fill_in 'Description', with: 'description'
      fill_in 'Cost', with: 1.0
      click_button 'Create Drug'
      expect(page).to have_content('Drug was successfully created.')
      # save_and_open_page
    end
  end
end
