require 'rails_helper'
require 'database_cleaner'

describe 'homepage' do 
  it 'should open page' do 
    visit root_path
    save_and_open_page
  end
end

describe 'homepage features' do
  it 'should click titlelink' do
    visit '/'
  end
end

describe 'homepage hospitals' do 
  it 'should visit hospitals from root path' do 
    visit root_path
    click_link 'Hospitals'
    save_and_open_page
  end

  it 'should fill in search bar' do 
    visit clinics_path
    fill_in 'srch-term', with: 'Clinic is awesome'
    click_button 'search'
    expect(page).to have_content('Clinic is awesome')
  end
end

describe 'homepage to prescriptions' do 
  it 'should visit prescriptions from root path' do 
    visit root_path
    click_link 'Prescriptions'
  end
end

describe 'homepage' do
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
    save_and_open_page
  end
end


describe 'going to a clinic' do
  it "should be able to go to a specific clinic" do
    visit clinics_path
    visit '/clinics/10'
    # save_and_open_page
  end
end

describe 'edit' do
  it 'should edit a clinic' do
    visit clinics_path
    visit '/clinics/10'
    visit '/clinics/10/edit'
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

describe 'delete clinic' do 
  it 'should delete a clinic' do
    visit clinics_path
    visit '/clinics/10'
    click_link 'Delete Clinic'
    expect(page).to have_content('Clinic was successfully deleted.')
    # save_and_open_page
  end
end

describe 'show clinic patients' do 
  it 'should show a clinics patients' do 
    visit clinics_path
    visit '/clinics/10'
    click_link 'View Clinic Patients'
    # save_and_open_page
  end
end

describe 'add a patient' do
  it 'should add a patient to a clinic' do 
    visit clinics_path
    visit '/clinics/10'
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

describe 'edit a patient' do 
  it 'should be able to edit a patient' do 
    visit clinics_path
    visit '/clinics/10'
    click_link 'Add Patient'
    fill_in 'First name', with: 'first name'
    fill_in 'Last name', with: 'last name'
    fill_in 'Description', with: 'description'
    fill_in 'DOB', with: '01/27/1990'
    choose 'patient_gender_male'
    select 'A+', from: 'Blood Type'
    click_button 'Create Patient'
    click_link 'Edit'
    save_and_open_page
  end
end

describe 'update a patient' do 
  it 'should be able to update a patient' do 
    visit clinics_path
    visit '/clinics/10'
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

describe 'add prescription' do 
  it 'should add a prescription to a clinic' do
    visit clinics_path
    visit '/clinics/10'
    click_link 'Add Prescription'
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 1.0
    click_button 'Create Drug'
    expect(page).to have_content('Drug was successfully created.')
    # save_and_open_page
  end
end
