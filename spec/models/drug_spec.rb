require 'rails_helper'

RSpec.describe Drug, type: :model do 
  subject do 
    FactoryGirl.create(:drug)
  end

  it {should validate_presence_of(:name)}

  it {should validate_presence_of(:description)}

  it {should validate_presence_of(:cost)}

  it {should have_many(:patients)}

  it "should have a name" do 
    expect(subject.name).to eq('name')
  end

  it 'shouldnt not have a name' do 
    expect(subject.name).not_to eq(nil)
  end

  it 'should have a description' do 
    expect(subject.description).to eq('description')
  end

  it 'shouldnt not have a description' do
    expect(subject.description).not_to eq(nil)
  end

  it 'should have a cost' do 
    expect(subject.cost).not_to eq(nil)
  end

end