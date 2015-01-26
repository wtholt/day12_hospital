class DrugsController < ApplicationController
  def index
    @drugs = Drug.all
  end

  def show
    @drug = Drug.find params[:id]
  end
    
  def new
    @drug = Drug.new
    @patients = Patient.all
  end
  
  def create
    @drug = Drug.create drug_params
    @patients = Patient.all
    redirect_to drugs_path
  end
  
  def edit
    @drug = Drug.find params[:id]
    @patients = Patient.all
  end

  def update
    @drug = Drug.find params[:id]
    @drug.update_attributes drug_params
    redirect_to drugs_path
  end

  def destroy
    @drug = Drug.find params[:id]
    @drug.destroy
    redirect_to drugs_path
  end

private
  def drug_params
    params.require(:drug).permit(
      :name,
      :description,
      :cost,
      patient_ids: []
    )
  end
end


