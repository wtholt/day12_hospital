class DrugsController < ApplicationController
  before_action :set_drug, only: [
    :show,
    :edit,
    :update,
    :destroy
  ]
  def index
    @drugs = if !params[:q].blank?
      Drug.where("name LIKE ? OR
        description LIKE ? OR
        cost LIKE ?", 
        "%#{params[:q]}%",
        "%#{params[:q]}%",
        "%#{params[:q]}%")
    else
      @drugs = Drug.all
    end
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
    if @drug.save
      flash[:notice] = 'Drug was successfully created.'
      redirect_to drugs_path
    else
      render :new
    end
  end
  
  def edit
    @patients = Patient.all
  end

  def update
    @drug.update_attributes drug_params
    respond_to do |format|
      format.html { redirect_to drugs_path, notice: 'Prescription updated.'}
    end
  end

  def destroy
    @drug.destroy
    respond_to do |format|
      format.html { redirect_to drugs_path, notice: 'Prescription deleted.'}
    end
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


