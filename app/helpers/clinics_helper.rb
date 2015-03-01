module ClinicsHelper
  def workflow_state_helper_method(patient)
    if patient.current_state == "waiting_room"
      "Patient is in the waiting room"
    elsif patient.current_state == "doctor"
      "Patient is with the Doctor"
    elsif patient.current_state == "xray"
      "Patient is in the examination room"
    elsif patient.current_state == "surgery"
      "Patient is in surgery"
    elsif patient.current_state == "paying"
      "Patient is paying"
    elsif patient.current_state == "leaving"
      "Patient is being discharged"
    else
      "Patient is in the waiting room"
    end
  end

end
