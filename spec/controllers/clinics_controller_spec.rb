require 'rails_helper'

describe ClinicsController do 
  let!(:clinic) { FactoryGirl.create(:clinic) }
  let!(:doctor) { FactoryGirl.create(:doctor) }
  let!(:patient) { FactoryGirl.create(:patient) }
 
  describe 'GET #index' do 
    let!(:clinic1) {
      Clinic.create({
        name: 'name',
        address: 'address',
        city: 'city',
        state: 'state',
        zip: 11111
        })
    }
    let!(:clinic2) {
      Clinic.create({
        name: 'n',
        address: 'address',
        city: 'city',
        state: 'state',
        zip: 11111
        })
    }
    let!(:clinic3) {
      Clinic.create({
        name: 'na',
        address: 'address',
        city: 'city',
        state: 'state',
        zip: 11111
        })
    }
    it 'should not return any clinics' do 
      get :index, q: 'asdf'
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics)).to eq([])
      # expect(response).to render_template :index
    end

    it 'should return only 1 clinic' do
      get :index, q: 'name'
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics)).to eq([clinic1])
    end
     it 'should return all clinics' do
      get :index, q: 'n'
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics)).to include(clinic1) 
      expect(assigns(:clinics)).to include(clinic2) 
      expect(assigns(:clinics)).to include(clinic3) 
    end
    it 'should return all clinics' do
      get :index, q: ""
      expect(assigns(:clinics)).not_to eq(nil)
      expect(assigns(:clinics)).to include(clinic1) 
      expect(assigns(:clinics)).to include(clinic2) 
      expect(assigns(:clinics)).to include(clinic3) 
    end
  end

  describe 'GET #show' do

    let(:patient1) {
      Patient.create({
        first_name: 'first name',
        last_name: 'last name',
        dob: 12.years.ago,
        description: 'description',
        gender: 'gender',
        blood_type: 'blood_type'
        })
    }
    let(:patient2) {
      Patient.create({
        first_name: 'first name',
        last_name: 'last name',
        dob: 12.years.ago,
        description: 'description',
        gender: 'gender',
        blood_type: 'blood_type'
        })
    }
    let(:patient3) {
      Patient.create({
        first_name: 'first name',
        last_name: 'last name',
        dob: 12.years.ago,
        description: 'description',
        gender: 'gender',
        blood_type: 'blood_type'
        })
    }

    it 'should show a clinic object' do
      get :show, id: clinic
      expect(assigns(:clinic)).to eq clinic
      expect(assigns(:clinic)).not_to eq nil
      expect(response).to render_template :show
    end

    it 'should have a relationship with patients' do
      get :show, id: clinic
      expect(assigns(:patients).length).to eq(0)
      expect(assigns(:patients)).to eq([])
      expect(assigns(:patients).class).to eq(Patient::ActiveRecord_Associations_CollectionProxy)
    end
  end

  describe 'GET #new' do
    it 'should initialize a new clinic' do 
      get :new
      expect(assigns(:clinic).class).to eq Clinic
      expect(assigns(:clinic).new_record?).to eq(true)
    end
  end

  describe 'POST #create' do 
    it 'should create a clinic' do
      clinic_params = FactoryGirl.attributes_for(:clinic)
      expect { post :create, :clinic => clinic_params }.to change(Clinic, :count).by(1)
      expect(flash[:notice]).to eq 'Clinic was successfully created'
      expect(response).to redirect_to clinics_path
    end
    it 'shouldnt create a clinic' do 
      expect { post :create, :clinic => { name: '', 
      description: '',
      address: '',
      city: '',
      state: '',
      zip: 29464}}.to_not change(Clinic, :count)
      expect(flash[:error]).to eq 'Clinic was not saved'
      expect(response).to_not redirect_to clinics_path
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do 
    it 'should edit a clinic' do 
      get :edit, id: clinic
      expect(assigns(:clinic)).to eq clinic
      expect(assigns(:clinic)).not_to eq nil
    end
  end

  describe 'PATCH #update' do
    context 'with good data' do
      it 'updates clinic and redirects' do
        clinic_params = FactoryGirl.attributes_for(:clinic)
        patch :update, id: clinic, clinic: clinic_params
        expect(response).to redirect_to clinics_path
        expect(flash[:notice]).to eq 'Clinic updated.'
      end 
    end
    context 'with bad data' do 
      it 'does not update' do
        patch :update, id: clinic, clinic:{ name: '', 
        description: '',
        address: '',
        city: '',
        state: '',
        zip: ''}
        expect(response).not_to redirect_to clinics_path
        expect(flash[:error]).to eq 'Clinic was not saved'
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the clinic' do
      expect{
        delete :destroy, id: clinic
      }.to change(Clinic, :count).by(-1)
      expect(response).to redirect_to clinics_path
      expect(flash[:notice]).to eq 'Clinic was successfully deleted.' 
    end
  end

  describe 'POST #create_doctor' do 
    it 'should create a doctor' do 
      expect{
        post :create_doctor, id: clinic, doctor: { name: 'Name' 
          }}.to change(Doctor, :count).by(1)
      expect(assigns(:clinic)).to eq clinic
      expect(assigns(:doctor).class).to eq Doctor
      expect(assigns(:doctor).doctorable_id).to eq clinic.id
      expect(assigns(:doctor).doctorable_type).to eq "Clinic"
      expect(response).to redirect_to clinic_path(clinic)
    end
  end

  describe 'DELETE #destroy_doctor' do 
    it 'should delete a doctor' do 
      doctor
      Doctor.count(1)
      expect{
        delete :destroy_doctor, id: doctor
      }
      Doctor.count(0)
    end
  end

end