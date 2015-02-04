module ClinicsHelper
  def workflow_state_helper_method(patient)
    if patient.workflow_state == "waiting_room"
      "Patient is in the waiting room"
    elsif patient.workflow_state == "doctor"
      "Patient is with the Doctor"
    elsif patient.workflow_state == "xray"
      "Patient is in the examination room"
    elsif patient.workflow_state == "surgery"
      "Patient is in surgery"
    elsif patient.workflow_state == "paying"
      "Patient is paying"
    elsif patient.workflow_state == "leaving"
      "Patient is being discharged"
    else
      "Patient is in the waiting room"
    end
  end

end
