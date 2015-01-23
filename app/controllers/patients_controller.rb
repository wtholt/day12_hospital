class PatientsController < ApplicationController
  def index
    @patients = Patient.all
    # @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
  end

  def show
    @clinic = Clinic.find params[:clinic_id]
    @patient = Patient.find params[:id]
  end

  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.new
  end
  
  def create
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.create patient_params
    redirect_to @clinic
  end
  
  def edit
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
  end
  
  def update
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    @patient.update_attributes patient_params
    redirect_to @clinic
  end
  
  def destroy
    @patient = Patient.find params[:id]
    @clinic = Clinic.find params[:clinic_id]
    @patient.delete
    redirect_to @clinic
  end

private

  def patient_params
    params.require(:patient).permit(
        :first_name,
        :last_name,
        :dob,
        :description,
        :gender,
        :blood_type
      )
  end
end


  def set_clinic
    @clinic = Clinic.find(params[:id])
  end
