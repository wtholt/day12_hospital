require 'rails_helper'

feature 'clinic/patients' do 
  given!(:clinic) { FactoryGirl.create(:clinic) }
  given!(:patient) { FactoryGirl.create(:patient) }

  context 'show clinic patients' do 
    it 'should show a clinics patients' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'View Clinic Patients'
      # save_and_open_page
    end
  end

  context 'add a patient' do
    it 'should add a patient to a clinic' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      expect(page).to have_content('Patient was successfully created.')
      expect(page).to have_content('Edit')
      expect(page).to have_content('Patient is in the waiting room')
    end
  end

  context 'show a patient' do 
    it 'should be able to show a patient' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'View Patient Records'
    end
  end

  context 'edit a patient' do 
    it 'should be able to edit a patient' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'Edit'
      # save_and_open_page
    end
  end

  context 'update a patient' do 
    it 'should be able to update a patient' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'Edit'
      fill_in 'First name', with: 'first name has been updated'
      fill_in 'Last name', with: 'last name has been updated'
      fill_in 'Description', with: 'description has been updated'
      fill_in 'DOB', with: '01/28/1990'
      choose 'patient_gender_female'
      select 'AB+', from: 'Blood Type'
      click_button 'Update Patient'
      expect(page).to have_content('Patient updated')
    end
  end

  context 'delete a patient' do 
    it 'should be able to delete a patient' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'Delete'
      # save_and_open_page
      expect(page).to have_content('Patient deleted.')
    end
  end

  context 'assign doctor to patient' do 
    it 'should be able to add a doctor to a patient' do  
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'View Patient Records'
      fill_in 'Name', with: 'Dr. Dog'
      click_button 'Create Doctor'
      expect(page).to have_content('Dr. Dog')
    end
  end

  context 'delete or reassign doctor from patient' do 
    it 'should be able to delete a doctor' do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'View Patient Records'
      fill_in 'Name', with: 'Dr. Dog'
      click_button 'Create Doctor'
      click_link 'Delete Doctor'
      expect(page).not_to have_content('Dr. Dog')
    end
  end

  context 'change patient workflow state to doctor' do 
    it 'should be able to send patient to doctor', js: true do 
      visit clinics_path
      click_link 'clinic'
      click_link 'Add Patient'
      fill_in 'First name', with: 'first name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Description', with: 'description'
      fill_in 'DOB', with: '01/27/1990'
      choose 'patient_gender_male'
      select 'A+', from: 'Blood Type'
      click_button 'Create Patient'
      click_link 'View Patient Records'
      # save_and_open_page
      page.click_link 'Doctor Check-Up'
      # save_and_open_page
      page.refresh
      expect(page).to have_content('Patient state: Patient is with the Doctor')
      # save_and_open_page
    end
  end
end