require 'rails_helper'

describe 'add a prescription' do 
  it 'should be able to add a prescription' do
    visit root_path
    click_link 'Prescriptions'
    click_link 'Add another Prescription'
    # save_and_open_page 
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    # save_and_open_page
    expect(page).to have_content('Drug was successfully created')
  end
end

describe 'edit a prescription' do 
  it 'should be able to edit a prescription' do 
    visit root_path
    click_link 'Prescriptions'
    click_link 'Add another Prescription' 
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    click_link 'Edit'
  end
end

describe 'update a prescription' do 
  it 'should be able to update a prescription' do 
    visit root_path
    click_link 'Prescriptions'
    click_link 'Add another Prescription' 
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    click_link 'Edit'
    fill_in 'nameInput', with: 'name has been updated'
    fill_in 'Description', with: 'description has been updated'
    fill_in 'Cost', with: 50.0
    click_button 'Create Drug'
    expect(page).to have_content('Prescription updated.')
  end
  it 'should be able to delete a prescription' do 
    visit root_path
    click_link 'Prescriptions'
    click_link 'Add another Prescription' 
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    click_link 'Delete'
    # save_and_open_page
    expect(page).to have_content('Prescription deleted.')
  end
end

describe 'show prescription' do 
  it 'should be able to show a prescription' do 
    visit drugs_path
    click_link 'Add another Prescription'
    fill_in 'nameInput', with: 'name'
    fill_in 'Description', with: 'description'
    fill_in 'Cost', with: 2.0
    click_button 'Create Drug'
    visit drugs_path
    click_link 'name'
    save_and_open_page
  end
end

describe 'edit from show page' do 
  it 'should be able to edit from show page' do 
    Drug.create({
      name: 'name',
      description: 'drug',
      cost: 2.0
      })
    visit drugs_path
    click_link 'name'
    click_link 'Edit'
  end
end

describe 'update from show page' do 
  it 'should be able to update from show via edit' do 
    Drug.create({
      name: 'name',
      description: 'description',
      cost: 2.0
      })
    visit drugs_path
    click_link 'name'
    click_link 'Edit'
    fill_in 'nameInput', with: 'name has been updated'
    fill_in 'Description', with: 'description has been updated'
    fill_in 'Cost', with: 50.0
    # save_and_open_page
    click_button 'Create Drug'
    expect(page).to have_content('Prescription updated')
    expect(page).not_to have_content('Prescription not saved')
    # save_and_open_page
  end
end