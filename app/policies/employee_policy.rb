class EmployeePolicy < ApplicationPolicy

    def index?
        Boolean(user&.owner? || user&.counter? || user&.mechanic?)
    end

    def show?
        Boolean(user&.owner? || user&.counter? || user&.mechanic?)
    end

    def create?
        Boolean(user&.owner?)
    end

    def update?
        Boolean(user&.owner?)
    end

    def destroy?
        Boolean(user&.owner?)
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