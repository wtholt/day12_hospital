module PatientsHelper
  def patient_workflow(patient_object)
    patient_object.workflow_state
  end

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
  elsif patient.workflow_state == "wait"
    "Patient is in the Waiting Room"
  end
  end

  def patient_state?(patient)
    array_of_links = []
    waiting_room_links = [
      (link_to "Doctor Check-Up", 'javascript:void(0);', class: "check-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "X-Ray room", 'javascript:void(0);', class: "examine-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Surgery", 'javascript:void(0);', class: "operate-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Discharged", 'javascript:void(0);', class: "leave-patient", clinic_id: @clinic.id, patient_id: patient.id)
    ]
    doctor_links = [
      (link_to "X-Ray room", 'javascript:void(0);', class: "examine-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Surgery", 'javascript:void(0);', class: "operate-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Billing", 'javascript:void(0);', class: 'pay-patient', clinic_id: @clinic.id, patient_id: patient.id),
    ]
    xray_links = [
      (link_to "Doctor Check-Up", 'javascript:void(0);', class: "check-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Surgery", 'javascript:void(0);', class: "operate-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Billing", 'javascript:void(0);', class: 'pay-patient', clinic_id: @clinic.id, patient_id: patient.id),
    ]
    surgery_links = [
      (link_to "Doctor Check-Up", 'javascript:void(0);', class: "check-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "X-Ray room", 'javascript:void(0);', class: "examine-patient", clinic_id: @clinic.id, patient_id: patient.id),
      (link_to "Billing", 'javascript:void(0);', class: 'pay-patient', clinic_id: @clinic.id, patient_id: patient.id),
    ]
    paying_links = [
      (link_to "Discharged", 'javascript:void(0);', class: "leave-patient", clinic_id: @clinic.id, patient_id: patient.id)
    ]
    # if the patient has the checkup event on it
      # array_of_links.push(checkup link_to)

    # if the patient has the xray event on it
      # array_of_links.push(xray link_to)

    if patient.waiting_room?
      array_of_links.push(waiting_room_links)
      return array_of_links.join(' | ').html_safe
    elsif patient.doctor?
      array_of_links.push(doctor_links)
      return array_of_links.join(' | ').html_safe
    elsif patient.xray?
      array_of_links.push(xray_links)
      return array_of_links.join(' | ').html_safe
    elsif patient.surgery?
      array_of_links.push(surgery_links)
      return array_of_links.join(' | ').html_safe
    elsif patient.paying?
      array_of_links.push(paying_links)
      return array_of_links.join(' | ').html_safe
    end
  end

end
