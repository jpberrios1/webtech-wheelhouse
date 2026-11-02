class CustomerPolicy < ApplicationPolicy

    def index?
        Boolean(user&.owner? || user&.counter?)
    end

    def show?
        Boolean(user&.owner? || user&.counter?)
    end

    def create?
        Boolean(user&.owner? || user&.counter?)
    end

    def update?
        Boolean(user&.owner? || user&.counter?)
    end

    def destroy?
        Boolean(user&.owner?)
    end

    class Scope < ApplicationPolicy::Scope
        def resolve
            if user&.owner? || user&.counter?
                scope.all
            else
                scope.none
            end
        end
    end
end