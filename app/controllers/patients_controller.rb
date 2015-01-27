class PatientsController < ApplicationController
  def index
    @patients = Patient.all
    # @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
  end

  def show
    @clinic = Clinic.find params[:clinic_id]
    @patient = Patient.find params[:id]
    @drugs = @patient.drugs
    @doctor = Doctor.new
    @doctors = @patient.doctors
  end

  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.new
    @drugs = Drug.all
    @doctors = Doctor.all
  end
  
  def create
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.create patient_params
    @drugs = Drug.all
    if @patient.save
      flash[:notice] = 'Patient was successfully created.'
    redirect_to @clinic
  else
      flash[:error] = 'Patient was not saved!'
      render :new
    end
  end
  
  def edit
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    @drugs = Drug.all
    @doctors = @patient.doctors
  end
  
  def update
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    @drugs = Drug.all
    @patient.update_attributes patient_params
    redirect_to @clinic
  end
  
  def destroy
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    @patient.destroy
    redirect_to @clinic
  end

  def create_doctor
    @clinic = Clinic.find params[:clinic_id]
    @patient = Patient.find params[:id]
    @doctor = @patient.doctors.create doctor_params
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def destroy_doctor
    @doctor = Doctor.find params[:id]
    @doctor.destroy
    redirect_to clinics_path
  end

private

  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :dob,
        :description,
        :gender,
        :blood_type,
        drug_ids: []
      )
  end
  def doctor_params
    params.require(:doctor).permit(
        :name,
    )
  end



end


  def set_clinic
    @clinic = Clinic.find params[:id]
  end
