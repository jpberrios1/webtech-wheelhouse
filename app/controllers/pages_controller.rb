class PagesController < ApplicationController 

    allow_unauthenticated_access only: %i[home about visiting]

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