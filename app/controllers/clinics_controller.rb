class ClinicsController < ApplicationController
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]
  def index
    @clinics = Clinic.all 
  end

  def show
    @patients = @clinic.patients
  end

  def new
    @clinic = Clinic.new
  end

  def edit
    @clinic = Clinic.find params[:id]
  end

  def create
    @clinic = Clinic.create clinic_params
    redirect_to root_path
  end
  

  def update
    @clinic = Clinic.find params[:id]
    @clinic.update_attributes clinic_params
    redirect_to root_path
  end

  def destroy
    @clinic = Clinic.find params[:id]
    @clinic.delete
    redirect_to root_path
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
end

private
  def set_clinic
    @clinic = Clinic.find(params[:id])
  end
