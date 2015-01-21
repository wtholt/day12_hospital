class PatientsController < ApplicationController
  def show
    @patient = Patient.find params[:id]
  end
  def new
    @patient = Patient.new
  end
  def create
    @patient = Patient.create patient_params
    if @patient.save
      flash[:notice] = 'Patient was successfully created.'
      redirect_to root_path
    else
      flash[:error] = 'Patient was not saved!'
      render :new
    end
  end
  def edit
    @patient = Patient.find params[:id]
  end
  def update
    @patient = Patient.find params[:id]
    @patient.update_attributes patient_params
    redirect_to root_path
  end
  def destroy
    @patient = Patient.find params[:id]
    @patient.delete
    redirect_to root_path
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
