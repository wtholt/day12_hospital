class ClinicsController < ApplicationController
  require 'enumerator'
  before_action :set_clinic, only: [
    :show, 
    :edit, 
    :update, 
    :destroy,
    :create_doctor,
  ]
  def index
    @clinics = Clinic.all
  end

  def show
    @patients = @clinic.patients
    @doctor = Doctor.new
    @doctors = if !params[:q].blank?
      @clinic.doctors.where("name LIKE ?", "%#{params[:q]}%")
    else 
      @doctors = @clinic.doctors
    end
  end

  def new
    @clinic = Clinic.new
  end

  def edit
  end

  def create
    @clinic = Clinic.create clinic_params
    if @clinic.save
      flash[:notice] = 'Clinic was successfully created'
      redirect_to clinics_path
    else
      flash[:error] = 'Clinic was not saved'
      render :new
    end
  end
  

  def update
    @clinic.update_attributes clinic_params
    respond_to do |format|
      format.html { redirect_to clinics_path, notice: 'Clinic updated.'}
    end
  end

  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_path, notice: 'Clinic was successfully deleted.'}
    end
  end

  def create_doctor
    @doctor = @clinic.doctors.create doctor_params
    redirect_to clinic_path(@clinic)
  end

  def destroy_doctor
    #@clinic = Clinic.find params[:id]
    @doctor = Doctor.find params[:id]
    @doctor.destroy
    redirect_to @doctor.doctorable
  end

  def search
    @clinics = Clinic.where("name LIKE ?", "%#{params[:search_clinic_name]}%")
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


# Clinic.where("name LIKE ? OR 
#         address LIKE ? OR 
#         city LIKE ? OR 
#         state LIKE ? OR
#         zip LIKE ?",
#         "%#{params[:q]}%",
#         "%#{params[:q]}%",
#         "%#{params[:q]}%",
#         "%#{params[:q]}%",
#         "%#{params[:q]}%",)
