class PagesController < ApplicationController 

    allow_unauthenticated_access only: %i[home about visiting]
    skip_after_action :verify_authorized

    def home
    end

    def services
        @services = StandardService.all
    end

    def visiting
    end

    def about
    end
end