class DrugsController < ApplicationController
  before_action :set_drug, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  def index
    @drugs = Drug.all
  end

  def show
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
    @patients = Patient.all
  end

  def update
    @drug.update_attributes drug_params
    redirect_to drugs_path
  end

  def destroy
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

private
  def set_drug
    @drug = Drug.find params[:id]
  end


