require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject do 
    FactoryGirl.create(:doctor)
  end 

  it {should belong_to(:doctorable)}

  it "should have a name" do 
    expect(subject.name).to eq('name')
  end

  it 'shouldnt not have a name' do
    expect(subject.name).not_to eq(nil)
  end




end