class DrugsController < ApplicationController
  def index
    @drugs = Drug.all
  end
  
  def show
    @drug = Drug.find params[:id]
  end
  
  def new
    @clinic = Clinic.find params[:clinic_id]
    @patient = @clinic.patients.find params[:patient_id]
    @drug = @patient.drugs.new
  end
  
  def create
    @drug = Drug.create drug_params
    redirect_to drugs_path
  end
  
  def edit
    @drug = Drug.find params[:id]
  end

  def update
    @drug = Drug.find params[:id]
    @drug.update_attributes drug_params
    redirect_to drugs_path
  end

  def destroy
    @drug = Drug.find params[:id]
    @drug.delete
    redirect_to drugs_path
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


