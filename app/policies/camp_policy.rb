class CampPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user&.organizer? || user&.admin?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin? && record.draft?
  end

  def publish?
    owner_or_admin? && record.draft?
  end

  def cancel?
    owner_or_admin? && !record.cancelled?
  end

  def manage_registrations?
    owner_or_admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.organizer?
        scope.where(organizer: user)
      else
        scope.visible
      end
    end
  end

  private

  def owner_or_admin?
    user&.admin? || record.organizer_id == user&.id
  end
end
