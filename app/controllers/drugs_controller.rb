class DrugsController < ApplicationController
  def index
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drugs = @patient.drugs
  end
  
  def show
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.find params[:id]
  end
  
  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.new
  end
  
  def create
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.create drug_params
    redirect_to clinic_patient_drugs_path(@clinic, @patient)
  end
  
  def edit
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.find params[:id]
  end

  def update
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.find params[:id]
    @drug.update_attributes drug_params
    redirect_to clinic_patient_drugs_path(@clinic, @patient)
  end

  def destroy
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.find params[:id]
    @drug.delete
    redirect_to clinic_patient_drugs_path(@clinic, @patient)
  end

private
  def drug_params
    params.require(:drug).permit(
      :name,
      :description,
      :cost,
    )
  end
end


