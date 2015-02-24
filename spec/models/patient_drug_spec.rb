require 'rails_helper'

RSpec.describe PatientDrug, type: :model do 

  it {should belong_to(:patient)}

  it {should belong_to(:drug)}

end