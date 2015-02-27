require 'rails_helper'

describe PatientsController do 
  let!(:clinic) { FactoryGirl.create(:clinic) }
  let!(:patient) { FactoryGirl.create(:patient) }
  let!(:drug) { FactoryGirl.create(:drug) }
  let!(:doctor) { FactoryGirl.create(:doctor) }

  describe 'GET #index' do 
    it 'should return all patients' do 
      get :index, id: patient, clinic_id: clinic
      expect(assigns(:patients)).not_to eq(nil)
    end
  end

  describe 'GET #show' do 
    it 'should show a patient object' do 
      get :show, id: patient, clinic_id: clinic
      expect(assigns(:patient)).to eq patient
      expect(assigns(:patient)).not_to eq(nil)
      expect(response).to render_template :show
    end

    # it 'should show a drug object' do
    #   get :show, id: drug, patient: patient
    #   expect(assigns(:drug)).to eq drug
    #   expect(assigns(:drug)).not_to eq(nil)
    #   expect(response).to render_template :show
    # end

    # it 'should initialize a new doctor object' do 
    #   get :show, id: doctor, doctorable_type: patient
    # end
  end

  describe 'GET #new' do 
    it 'should initialize a new patient' do 
      get :new, id: patient, clinic_id: clinic
      expect(assigns(:patient).class).to eq Patient
      expect(assigns(:patient).new_record?).to eq(true)
    end
    
    it 'should show all drugs' do
      get :new, id: patient, clinic_id: clinic
      expect(assigns(:drugs)).not_to eq(nil) 
      expect(assigns(:doctors)).not_to eq(nil)
    end
  end

  describe 'POST #create' do 
    context 'with good data' do 
      it 'should create and redirect' do 
        patient_params = FactoryGirl.attributes_for(:patient)
        expect{
          post :create, :patient => patient_params, clinic_id: clinic
        }.to change(Patient, :count).by(1)
        expect(flash[:notice]).to eq 'Patient was successfully created.'
        expect(response).to redirect_to clinic_patients_path(clinic)
      end
    end
    context 'with bad data' do 
      it 'shouldnt create and redirect' do 
        expect{
          post :create, patient: {
            first_name: '',
            last_name: '',
            dob: '',
            description: '',
            gender: '',
            blood_type: ''
          }, clinic_id: clinic
        }.to_not change(Patient, :count)
        expect(flash[:error]).to eq 'Patient was not saved!'
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do 
    it 'should edit a patient' do 
      get :edit, id: patient, clinic_id: clinic
      expect(assigns(:patient)).to eq patient
      expect(assigns(:patient)).not_to eq(nil)
    end
  end

  describe 'PATCH #update' do 
    context 'with good data' do
      it 'updates patient and redirects' do 
        patient_params = FactoryGirl.attributes_for(:patient)
        patch :update, id: patient, patient: patient_params, clinic_id: clinic
        expect(flash[:notice]).to eq 'Patient updated'
        expect(response).to redirect_to clinic_patient_path(clinic, patient)
      end 
    end
    context 'with bad data' do 
      it 'doesnt update patient and redirect' do 
        patch :update, id: patient, patient: {
          first_name: '',
          last_name: '',
          dob: '', 
          description: '',
          gender: '',
          blood_type: ''
        }, clinic_id: clinic
        expect(flash[:error]).to eq 'Patient was not updated'
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do 
    it 'should delete a patient' do 
      patient
      expect{
        delete :destroy, id: patient, clinic_id: clinic
      }.to change(Patient, :count).by(-1)
      expect(flash[:notice]).to eq 'Patient deleted.'
      expect(response).to redirect_to clinic_patients_path(clinic)
    end
  end


  # def update
  #   @drugs = Drug.all
  #   @patient.update_attributes patient_params
  #   redirect_to clinic_patient_path(@clinic, @patient)
  # end








end