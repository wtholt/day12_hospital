require 'rails_helper'

describe DrugsController do 
  let(:drug) {
    FactoryGirl.create(:drug)
  }

  describe 'GET #index' do
    let!(:drug1) {
      Drug.create({name: 'name', description: 'description', cost: 1.0})
    } 
    let!(:drug2) {
      Drug.create({name: 'na', description: 'description', cost: 1.0})
    } 
    let!(:drug3) {
      Drug.create({name: 'n', description: 'description', cost: 1.0})
    } 
    it 'should return all drugs' do 
      get :index, q: 'asdf'
      expect(assigns(:drugs)).not_to eq(nil)
      expect(assigns(:drugs)).to eq([])
    end

    it 'should return only 1 drug' do 
      get :index, q: 'name'
      expect(assigns(:drugs)).not_to eq(nil)
      expect(assigns(:drugs)).to eq([drug1])
    end

    it 'should return all' do 
      get :index, q: 'n'
      expect(assigns(:drugs)).not_to eq(nil)
      expect(assigns(:drugs)).to include(drug1)
      expect(assigns(:drugs)).to include(drug2)
      expect(assigns(:drugs)).to include(drug3)
    end

    it 'should return all' do 
      get :index, q: ''
      expect(assigns(:drugs)).not_to eq(nil)
      expect(assigns(:drugs)).to include(drug1)
      expect(assigns(:drugs)).to include(drug2)
      expect(assigns(:drugs)).to include(drug3)
    end
  end

  describe 'GET #show' do 
    it 'should show a drug object' do 
      get :show, id: drug
      expect(assigns(:drug)).to eq drug
      expect(assigns(:drug)).to_not eq(nil)
    end
  end

  describe 'GET #new' do 
    it 'should initialize a new clinic' do 
      get :new
      expect(assigns(:drug).class).to eq Drug
      expect(assigns(:drug).new_record?).to eq(true)
    end
  end

  describe 'POST #create' do 
    context 'with good data' do 
      it 'creates new drug and redirects' do
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          post :create, drug: drug_params
        }.to change(Drug, :count).by(1)
        expect(flash[:notice]).to eq 'Drug was successfully created.' 
        expect(response).to redirect_to drugs_path
      end
    end
    context 'with bad data' do 
      it 'shouldnt create a new drug and/or redirect' do 
        expect{
          post :create, :drug => {
            name: '',
            description: '',
            cost: ''
          }
        }.to_not change(Drug, :count)
        expect(flash[:error]).to eq 'Drug was not saved.'
        expect(response).to_not redirect_to drugs_path
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do 
    it 'should edit a drug' do 
      get :edit, id: drug
      expect(assigns(:drug)).to eq drug
      expect(assigns(:drug)).not_to eq nil
    end
  end

  describe 'PATCH #update' do 
    context 'with good data' do 
      it 'updates drug and redirects' do 
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          patch :update, id: drug, drug: drug_params
          expect(response).to redirect_to drugs_path
          expect(flash[:notice]).to eq 'Prescription updated.'
        }
      end
    end
    context 'with bad data' do 
      it 'shouldnt update drug and redirect' do
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          patch :update, id: drug, drug:{
            name: '',
            description: '',
            cost: ''
          }
        } 
        expect(response).not_to redirect_to drugs_path
      end
      it 'shouldnt update' do 
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          patch :update, id: drug, drug:{
            name: 'name',
            description: '',
            cost: ''
          }
        }
        expect(response).not_to redirect_to drugs_path 
      end

      it 'shouldnt update' do 
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          patch :update, id: drug, drug:{
            name: '',
            description: 'name',
            cost: ''
          }
        }
        expect(response).not_to redirect_to drugs_path 
      end

      it 'shouldnt update' do 
        drug_params = FactoryGirl.attributes_for(:drug)
        expect{
          patch :update, id: drug, drug:{
            name: '',
            description: '',
            cost: 5.0
          }
        }
        expect(response).not_to redirect_to drugs_path 
      end
    end
  end

  describe 'DELETE #destroy' do 
    it 'should delete a Prescription' do 
      drug 
      expect{
        delete :destroy, id: drug
      }.to change(Drug, :count).by(-1)
    expect(response).to redirect_to drugs_path
    expect(flash[:notice]).to eq 'Prescription deleted.'
    end
  end

end