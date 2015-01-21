class Patient < ActiveRecord::Base
  BLOOD_TYPES = [
    ["A+", "A+"],
    ["A-", "A-"],
    ["B+", "B+"],
    ["B-", "B-"],
    ["AB+", "AB+"],
    ["AB-", "AB-"],
    ["O+", "O+"], 
    ["O-", "O-"]
  ]
end
