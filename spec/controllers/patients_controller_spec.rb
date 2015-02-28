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

    it 'should show a drug object' do
      get :show, id: patient, clinic_id: clinic
      expect(assigns(:patient)).to eq patient
      expect(assigns(:drugs).length).to eq(0)
      expect(assigns(:drugs)).to eq([])
      expect(assigns(:drugs).class).to eq(Drug::ActiveRecord_Associations_CollectionProxy)
    end

    it 'should show a doctor object' do 
      get :show, id: patient, clinic_id: clinic
      expect(assigns(:patient)).to eq patient
      expect(assigns(:doctor).new_record?).to eq(true)
      expect(assigns(:doctor).class).to eq(Doctor)
    end

    # it 'should initialize a new doctor object' do 
    #   get :show, id: doctor, doctorable_type: patient
    # end
  end

  describe 'GET #new' do 
    it 'should initialize a new patient' do 
      get :new, id: patient, clinic_id: clinic
      expect(assigns(:patient).class).to eq Patient
      expect(assigns(:patient)).not_to eq nil
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

  describe 'POST #create_doctor' do 
    it 'should create a doctor' do 
      expect{
        post :create_doctor, id: patient, clinic_id: clinic, doctor: {
          name: 'Name'
        }
      }.to change(Doctor, :count).by(1)
      expect(assigns(:patient)).to eq patient
      expect(assigns(:doctor).class).to eq Doctor
      expect(assigns(:doctor).doctorable_id).to eq patient.id
      expect(assigns(:doctor).doctorable_type).to eq 'Patient'
      expect(response).to redirect_to clinic_patient_path(clinic, patient)
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

  describe 'PATCH #examine_patient' do 
    it 'should send the patient to xray' do 
      xhr :patch, :examine_patient, id: patient, clinic_id: clinic
    end
  end

  # describe 'PATCH #wait_patient' do 
  #   it 'should send the patient to the waiting room' do 
  #     xhr :patch, :wait_patient, id: patient, clinic_id: clinic
  #   end
  # end

  describe 'PATCH #operate_patient' do 
    it 'should send the patient to surgery' do 
      xhr :patch, :operate_patient, id: patient, clinic_id: clinic
    end
  end

  describe 'PATCH #check_patient' do 
    it 'should send the patient to the doctor' do 
      xhr :patch, :check_patient, id: patient, clinic_id: clinic
    end
  end

  describe 'PATCH #pay_patient' do 
    it 'should send the patient to billing' do
      patient.check! 
      xhr :patch, :pay_patient, id: patient, clinic_id: clinic
    end
  end

  describe 'PATCH #leave_patient' do 
    it 'should discharge the patient' do 
      patient.check!
      patient.pay!
      xhr :patch, :leave_patient, id: patient, clinic_id: clinic
    end
  end

  # def update
  #   @drugs = Drug.all
  #   @patient.update_attributes patient_params
  #   redirect_to clinic_patient_path(@clinic, @patient)
  # end








end