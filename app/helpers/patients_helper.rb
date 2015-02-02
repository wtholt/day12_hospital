module PatientsHelper
  def patient_workflow(patient_object)
    patient_object.workflow_state
  end
end
