class RepairPolicy < ApplicationPolicy

    def index?
        user&.owner? || user&.counter? || user&.mechanic?
    end

    def show?
        return false unless user.present?

        user.owner? || user.counter? || own_repair?
    end

    def create?
        user&.owner? || user&.counter?
    end

    def update?
        return false unless user.present?
        return true if user.owner?
        return false if record.handed_back?

        user.counter? || own_repair?
    end

    def destroy?
        user&.owner?
    end

    def remove_photo?
        return false unless user.present?
        return true if user.owner?
        return false if record.handed_back?

        user.counter?
    end


    def permitted_attributes
        if user&.owner? || user&.counter?
            [:bike_id,
             :mechanic_id,
             :state,
             :is_approved,
             :promised_on,
             :handed_back_at,
             :diagnosis,
             {intake_photos: []},
             {repair_services_attributes: %i[id standard_service_id charged_price _destroy]}
        ]
        elsif user&.mechanic?
            [:state,
             :diagnosis,
             {intake_photos: []}
            ]
        else
            []
        end
    end

    class Scope < ApplicationPolicy::Scope
        def resolve
            return scope.none unless user.present?

            if user.owner? || user.counter?
                scope.all
            elsif user.mechanic? && user.employee.present?
                scope.where(mechanic_id: user.employee.id)
            else
                scope.none
            end
        end
    end

    private 

    def own_repair?
        user&.mechanic? && user.employee.present? && record.mechanic_id == user.employee.id
    end

end