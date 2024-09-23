class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: %i[show edit update destroy]

  def index
    @patients = policy_scope(Patient)  # Use Pundit policy scope for index action
  end

  def show
    authorize @patient  # Authorize viewing the patient
  end

  def new
    @patient = Patient.new
    authorize @patient  # Authorize patient creation
  end

  def create
    @patient = Patient.new(patient_params)
    authorize @patient  # Authorize after the patient object is initialized
    if @patient.save
      redirect_to @patient, notice: 'Patient was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @patient  # Authorize editing the patient
  end

  def update
    authorize @patient  # Authorize updating the patient
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @patient  # Authorize destroying the patient
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :date_of_birth, :address, :phone)
  end
end
