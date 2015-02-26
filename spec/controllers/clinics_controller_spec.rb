require 'rails_helper'

describe ClinicsController do 
  let(:clinic) { FactoryGirl.create(:clinic) }
 
  describe 'GET #index' do 
    it 'gets the clinic index' do 
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'should show a clinic object' do
      get :show, id: clinic
      expect(assigns(:clinic)).to eq clinic
      expect(assigns(:clinic)).not_to eq nil
    end
  end

  describe 'GET #new' do
    it 'should initialize a new clinic' do 
      get :new
      expect(assigns(:clinic).class).to eq Clinic
      expect(assigns(:clinic).new_record?).to eq(true)
    end
  end

  describe 'POST #create' do 
    it 'should create a clinic' do
      clinic_params = FactoryGirl.attributes_for(:clinic)
      expect { post :create, :clinic => clinic_params }.to change(Clinic, :count).by(1)
      expect(flash[:notice]).to eq 'Clinic was successfully created'
      expect(response).to redirect_to clinics_path
    end
    it 'shouldnt create a clinic' do 
      expect { post :create, :clinic => { name: '', 
      description: '',
      address: '',
      city: '',
      state: '',
      zip: ''}}.to_not change(Clinic, :count)
      expect(flash[:error]).to eq 'Clinic was not saved'
      expect(response).to_not redirect_to clinics_path
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do 
    it 'should edit a clinic' do 
      get :edit, id: clinic
      expect(assigns(:clinic)).to eq clinic
      expect(assigns(:clinic)).not_to eq nil
    end
  end

  describe 'PATCH #update' do
    context 'with good data' do
      it 'updates clinic and redirects' do
        clinic_params = FactoryGirl.attributes_for(:clinic)
        patch :update, id: clinic, clinic: clinic_params
        expect(response).to redirect_to clinics_path
        expect(flash[:notice]).to eq 'Clinic updated.'
      end 
    end
    context 'with bad data' do 
      it 'does not update' do
        patch :update, id: clinic, clinic:{ name: '', 
        description: '',
        address: '',
        city: '',
        state: '',
        zip: ''}
        expect(response).not_to redirect_to clinics_path
        expect(flash[:error]).to eq 'Clinic was not saved'
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the clinic' do
      expect{
        delete :destroy, id: clinic
      }.to change(Clinic, :count).by(-1) 
    end
  end


# def destroy
#     @clinic.destroy
#     respond_to do |format|
#       format.html { redirect_to clinics_path, notice: 'Clinic was successfully deleted.'}
#     end
#   end


end