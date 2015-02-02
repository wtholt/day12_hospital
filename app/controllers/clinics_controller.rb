class ClinicsController < ApplicationController
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  def index
    @clinics = Clinic.all 
  end

  def show
    @patients = @clinic.patients
    @doctor = Doctor.new
    @doctors = @clinic.doctors
  end

  def new
    @clinic = Clinic.new
  end

  def edit
  end

  def create
    @clinic = Clinic.create clinic_params
    redirect_to root_path
  end
  

  def update
    @clinic.update_attributes clinic_params
    redirect_to root_path
  end

  def destroy
    @clinic.destroy
    redirect_to root_path
  end

  def create_doctor
    @clinic = Clinic.find params[:id]
    @doctor = @clinic.doctors.create doctor_params
    redirect_to clinic_path(@clinic)
  end

  def destroy_doctor
    #@clinic = Clinic.find params[:id]
    @doctor = Doctor.find params[:id]
    @doctor.destroy
    redirect_to @doctor.doctorable
  end

  
private
  def clinic_params
    params.require(:clinic).permit(
        :name,
        :address,
        :city,
        :state,
        :zip,
      )
  end
  def doctor_params
    params.require(:doctor).permit(
      :name,
    )
  end
end

private
  def set_clinic
    @clinic = Clinic.find(params[:id])
  end
