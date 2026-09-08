class PagesController < ApplicationController 

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