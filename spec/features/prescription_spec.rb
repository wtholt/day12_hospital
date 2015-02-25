require 'rails_helper'

describe 'add a prescription' do 
  it 'should be able to add a prescription' do
    visit root_path
    click_link 'Prescriptions'
    click_link 'Add another Prescription'
    save_and_open_page 
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    save_and_open_page
    expect(page).to have_content('Drug was successfully created')
  end
end