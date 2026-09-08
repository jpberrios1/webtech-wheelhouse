# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


RepairService.destroy_all
Repair.destroy_all
Bike.destroy_all
BikeModel.destroy_all
StandardService.destroy_all
Employee.destroy_all
Customer.destroy_all


#=================STAFF========================

counter = Employee.create!(name: 'John Smith', role: 'Counter Clerk')
mech1 = Employee.create!(name: 'William Johnson', role: 'Mechanic')
mech2 = Employee.create!(name: 'Michael Brown', role: 'Mechanic')
mech3 = Employee.create!(name: 'Walter White', role: 'Mechanic')


#================ STANDARD SERVICES =================

services_data = [
    {name: 'Chain Replacement', price: 25.00},
    {name: 'Wheel Truing', price: 25.00},
    {name: 'Bike Cleaning', price: 15.00},
    {name: 'Pedal Replacement', price: 15.00},
    {name: 'Chain Adjustment', price: 15.00},
    {name: 'Wheel Replacement', price: 30.00},
    {name: 'Chain Lubrication', price: 10.00},
    {name: 'Flat Tire Repair', price: 15.00},
    {name: 'Inner Tube Replacement', price: 15.00},
    {name: 'Handlebar Replacement', price: 35.00},
    {name: 'Brake Adjustment', price: 20.00},
    {name: 'Shifter Cable Replacement', price: 25.00},
    {name: 'Basic Tune-up', price: 65.00},
    {name: 'Full Tune-up', price: 120.00},
    {name: 'Brake Bleed (Front)', price: 35.00},
    {name: 'Brake Bleed (Rear)', price: 35.00},
    {name: 'Suspension Service', price: 55.00},
    {name: 'Derailleur Adjustment', price: 15.00},
    {name: 'Hub Overhaul', price: 30.00},
    {name: 'Bottom Bracket Replacement', price: 35.00}
]

svc = services_data.map do |s|
    StandardService.create!(name: s[:name], current_price: s[:price])
end 

#============== CUSTOMERS ===========================
c1 = Customer.create!(name: 'Sophie Edwards', phone: '555-0001', is_regular: true)
c2 = Customer.create!(name: 'BoJack Horseman', phone: '555-0002', is_regular: false)
c3 = Customer.create!(name: 'Arthur Morgan', phone: '555-0003', is_regular: true)
c4 = Customer.create!(name: "John Marston", phone: '555-0004', is_regular: false)
c5 = Customer.create!(name: 'Walter White Jr.', phone: '555-0005', is_regular: true)
c6 = Customer.create!(name: 'Jesse Pinkman', phone: '555-0006', is_regular: false)
c7 = Customer.create!(name: 'Saul Goodman', phone: '555-0007', is_regular: true)
c8 = Customer.create!(name: 'William Afton', phone: '555-0008', is_regular: false)
c9 = Customer.create!(name: 'Gregory House', phone: '555-0009', is_regular: false)
c10 = Customer.create!(name: 'Malcolm Wilkerson', phone: '555-0010', is_regular: false)



#======= BIKE MODELS ==============

bm_trek = BikeModel.create!(name: 'Trek Marlin 7')
bm_spec = BikeModel.create!(name: 'Specialized Rockhopper')
bm_giant = BikeModel.create!(name: 'Giant Talon 2')


#============== BIKES ======================

b1 = Bike.create!(customer_id: c1.id, bike_model_id: bm_trek.id, serial_number: 'TRK-001')
b2 = Bike.create!(customer_id: c1.id, bike_model_id: bm_trek.id, serial_number: 'TRK-002')
b3 = Bike.create!(customer_id: c3.id, bike_model_id: bm_spec.id, serial_number: 'SPC-001')
b4 = Bike.create!(customer_id: c4.id, bike_model_id: bm_giant.id, serial_number: 'GNT-001')
b5 = Bike.create!(customer_id: c5.id, bike_model_id: bm_trek.id, serial_number: 'TRK-003')
b6 = Bike.create!(customer_id: c6.id, bike_model_id: bm_spec.id, serial_number: 'SPC-002')
b7 = Bike.create!(customer_id: c7.id, bike_model_id: bm_giant.id, serial_number: 'GNT-002')
b8 = Bike.create!(customer_id: c8.id, bike_model_id: bm_trek.id, serial_number: 'TRK-004')
b9 = Bike.create!(customer_id: c9.id, bike_model_id: bm_spec.id, serial_number: 'SPC-003')
b10 = Bike.create!(customer_id: c10.id, bike_model_id: bm_giant.id, serial_number: 'GNT-003')
b11 = Bike.create!(customer_id: c1.id, bike_model_id: bm_spec.id, serial_number: 'SPC-004')
b12 = Bike.create!(customer_id: c4.id, bike_model_id: bm_trek.id, serial_number: 'TRK-005')



#======================== REPAIRS =========================================

r1 = Repair.create!(bike_id: b1.id, mechanic_id: mech1.id, state: 'handed_back', promised_on: Date.new(2025, 11, 10), handed_back_at: Time.new(2025, 11, 10, 15, 30), is_approved: true, created_at: Time.new(2025, 11, 8))
RepairService.create!(repair_id: r1.id, standard_service_id: svc[0].id, charged_price: 15000) # Precio cobrado distinto al actual (25000)

r2 = Repair.create!(bike_id: b1.id, mechanic_id: mech2.id, state: 'handed_back', promised_on: Date.current - 5.days, handed_back_at: Time.current - 4.days, is_approved: true)
RepairService.create!(repair_id: r2.id, standard_service_id: svc[2].id, charged_price: svc[2].current_price)

r3 = Repair.create!(bike_id: b3.id, mechanic_id: mech1.id, state: 'declined', promised_on: nil, handed_back_at: Time.current - 1.day, is_approved: false)
RepairService.create!(repair_id: r3.id, standard_service_id: svc[1].id, charged_price: svc[1].current_price)

r4 = Repair.create!(bike_id: b4.id, mechanic_id: mech3.id, state: 'handed_back', promised_on: Date.current, handed_back_at: Time.current, is_approved: true)
RepairService.create!(repair_id: r4.id, standard_service_id: svc[17].id, charged_price: svc[17].current_price)

r5 = Repair.create!(bike_id: b5.id, mechanic_id: mech2.id, state: 'in_progress', promised_on: Date.current - 2.days, handed_back_at: nil, is_approved: true)
RepairService.create!(repair_id: r5.id, standard_service_id: svc[12].id, charged_price: svc[12].current_price)

r6 = Repair.create!(bike_id: b6.id, mechanic_id: mech1.id, state: 'handed_back', promised_on: Date.current - 1.day, handed_back_at: Time.current - 1.day, is_approved: true)
RepairService.create!(repair_id: r6.id, standard_service_id: svc[3].id, charged_price: 10000) # Precio normal es 15000

r7 = Repair.create!(bike_id: b7.id, mechanic_id: nil, state: 'received', promised_on: nil, handed_back_at: nil, is_approved: nil) # Mecánico aún no asignado
RepairService.create!(repair_id: r7.id, standard_service_id: svc[8].id, charged_price: svc[8].current_price)

r8 = Repair.create!(bike_id: b8.id, mechanic_id: mech3.id, state: 'quoted', promised_on: Date.current + 3.days, handed_back_at: nil, is_approved: nil)
RepairService.create!(repair_id: r8.id, standard_service_id: svc[9].id, charged_price: svc[9].current_price)

r9 = Repair.create!(bike_id: b9.id, mechanic_id: mech2.id, state: 'approved', promised_on: Date.current + 2.days, handed_back_at: nil, is_approved: true)
RepairService.create!(repair_id: r9.id, standard_service_id: svc[5].id, charged_price: svc[5].current_price)

r10 = Repair.create!(bike_id: b10.id, mechanic_id: mech1.id, state: 'ready', promised_on: Date.current, handed_back_at: nil, is_approved: true)
RepairService.create!(repair_id: r10.id, standard_service_id: svc[6].id, charged_price: svc[6].current_price)

r11 = Repair.create!(bike_id: b11.id, mechanic_id: mech2.id, state: 'in_progress', promised_on: Date.current + 1.day, handed_back_at: nil, is_approved: true)
RepairService.create!(repair_id: r11.id, standard_service_id: svc[15].id, charged_price: svc[15].current_price)

r12 = Repair.create!(bike_id: b12.id, mechanic_id: mech3.id, state: 'handed_back', promised_on: Date.current - 10.days, handed_back_at: Time.current - 10.days, is_approved: true)

RepairService.create!(repair_id: r12.id, standard_service_id: svc[1].id, charged_price: svc[1].current_price)
RepairService.create!(repair_id: r12.id, standard_service_id: svc[4].id, charged_price: svc[4].current_price)
RepairService.create!(repair_id: r12.id, standard_service_id: svc[7].id, charged_price: svc[7].current_price)
RepairService.create!(repair_id: r12.id, standard_service_id: svc[14].id, charged_price: svc[14].current_price)

r13 = Repair.create!(bike_id: b2.id, mechanic_id: mech1.id, state: 'ready', promised_on: Date.current + 1.day, handed_back_at: nil, is_approved: true)
RepairService.create!(repair_id: r13.id, standard_service_id: svc[13].id, charged_price: svc[13].current_price)

r14 = Repair.create!(bike_id: b3.id, mechanic_id: mech2.id, state: 'handed_back', promised_on: Date.current - 20.days, handed_back_at: Time.current - 19.days, is_approved: true)
RepairService.create!(repair_id: r14.id, standard_service_id: svc[11].id, charged_price: svc[11].current_price)

r15 = Repair.create!(bike_id: b5.id, mechanic_id: nil, state: 'received', promised_on: nil, handed_back_at: nil, is_approved: nil)
RepairService.create!(repair_id: r15.id, standard_service_id: svc[10].id, charged_price: svc[10].current_price)

puts "Database successfully populated."