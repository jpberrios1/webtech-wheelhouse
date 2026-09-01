class PagesController < ApplicationController 

    def home
    end

    def services
        @jobs = [
            {name: "Chain Replacement", price: 5000},
            {name: "Wheel Truing", price: 2000},
            {name: "Bike Cleaning", price: 1500},
            {name: "Pedal Replacement", price: 2000},
            {name: "Chain Adjustment", price: 2500},
            {name: "Wheel Replacement", price: 3500},
            {name: "Chain Lubrication", price: 4000},
            {name: "Flat Tire Repair", price: 1000},
            {name: "Inner Tube Replacement", price: 1200},
            {name: "Handlebar Replacement", price: 4000},
            {name: "Brake Adjustment", price: 3500},
            {name: "Shifter Cable Replacement", price: 4200}
        ]
    end

    def visiting
    end

    def about
    end
end