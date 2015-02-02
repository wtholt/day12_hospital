class PatientsController < ApplicationController
  before_action :set_patient, :set_clinic, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :create_doctor,
    :wait_patient,
    :check_patient,
    :examine_patient,
    :operate_patient,
    :leave_patient,
    :pay_patient,
  ]
  def index
    @patients = Patient.all
    # @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
  end

  def show
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
    @drugs = Drug.all
    @doctors = @patient.doctors
  end
  
  def update
    @drugs = Drug.all
    @patient.update_attributes patient_params
    redirect_to clinic_patient_path(@clinic, @patient)
  end
  
  def destroy
    @patient.destroy
    redirect_to @clinic
  end

  def create_doctor
    @doctor = @patient.doctors.create doctor_params
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def destroy_doctor
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to clinic_patient_path(@doctor.doctorable.clinic, @doctor.doctorable)
  end

  def wait_patient
    @patient.wait!
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def examine_patient
    @patient.examine!
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def operate_patient
    @patient.operate!
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def check_patient
    @patient.check!
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def pay_patient
    @patient.pay!
    redirect_to clinic_patient_path(@clinic, @patient)
  end

  def leave_patient
    @patient.leave!
    redirect_to clinic_patient_path(@clinic, @patient)
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
private
  def set_patient
    @patient = Patient.find params[:id]
  end
private
  def set_clinic
    @clinic = Clinic.find params[:clinic_id]
  end

end
