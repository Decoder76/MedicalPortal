# app/policies/patient_policy.rb
class PatientPolicy < ApplicationPolicy
  def create?
    user.receptionist?  # Only allow receptionists to create patients
  end

  def update?
    user.receptionist?
  end

  def destroy?
    user.receptionist?
  end

  def show?
    user.receptionist? || user.doctor?
  end

  # Define the scope for accessing patients
  class Scope < Scope
    def resolve
      if user.receptionist? || user.doctor?
        scope.all
      else
        scope.none
      end
    end
  end
end
