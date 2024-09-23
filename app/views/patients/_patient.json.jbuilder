json.extract! patient, :id, :first_name, :last_name, :date_of_birth, :address, :phone, :created_at, :updated_at
json.url patient_url(patient, format: :json)
