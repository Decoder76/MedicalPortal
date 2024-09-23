# spec/controllers/patients_controller_spec.rb

require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:receptionist) { create(:user, role: :receptionist) }
  let(:doctor) { create(:user, role: :doctor) }
  let(:patient) { create(:patient) }

  describe "Receptionist access" do
    before do
      sign_in receptionist
    end

    it "can view the list of patients" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:patients)).to include(patient)
    end

    it "can create a new patient" do
      expect {
        post :create, params: { patient: { first_name: 'John', last_name: 'Doe', date_of_birth: '1980-01-01', address: '123 Main St', phone: '1234567890' } }
      }.to change(Patient, :count).by(1)
      expect(response).to redirect_to(patient_path(assigns(:patient)))
    end

    it "can update an existing patient" do
      patch :update, params: { id: patient.id, patient: { first_name: 'Jane' } }
      expect(response).to redirect_to(patient_path(patient))
      patient.reload
      expect(patient.first_name).to eq('Jane')
    end

    it "can delete a patient" do
      patient_to_delete = create(:patient)
      expect {
        delete :destroy, params: { id: patient_to_delete.id }
      }.to change(Patient, :count).by(-1)
      expect(response).to redirect_to(patients_path)
    end
  end

  describe "Doctor access" do
    before do
      sign_in doctor
    end

    it "can view the list of patients" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:patients)).to include(patient)
    end

    it "cannot create a new patient" do
      post :create, params: { patient: { first_name: 'John', last_name: 'Doe' } }
      expect(response).to redirect_to(root_path)
    end

    it "cannot update a patient" do
      patch :update, params: { id: patient.id, patient: { first_name: 'Jane' } }
      expect(response).to redirect_to(root_path)
    end

    it "cannot delete a patient" do
      delete :destroy, params: { id: patient.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "Unauthorized access" do
    it "redirects to login page for unauthenticated users" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
