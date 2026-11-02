class StandardServicePolicy < ApplicationPolicy

    def index?
        true
    end

    def show?
        true
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
            scope.all
        end
    end
end