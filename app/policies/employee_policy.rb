class EmployeePolicy < ApplicationPolicy

    def index?
        user&.owner? || user&.counter? || user&.mechanic?
    end

    def show?
        user&.owner? || user&.counter? || user&.mechanic?
    end

    def create?
        user&.owner?
    end

    def update?
        user&.owner?
    end

    def destroy?
        user&.owner?
    end

    class Scope < ApplicationPolicy::Scope
        def resolve
            if user&.owner? || user&.counter? || user&.mechanic?
                scope.all
            else
                scope.none
            end
        end
    end
end