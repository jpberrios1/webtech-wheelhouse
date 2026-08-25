# Wheelhouse Bike Shop

## What is Wheelhouse?
Wheelhouse is a local bike repair shop. This project proposes a new system design and domain model to digitize their workflow. The system aims to manage active repairs, track specific physical bikes (using serial numbers) to prevent mix-ups, and maintain a standardized public price list to ensure consistent billing.

## Who uses it?
The system is designed to be used by four distinct roles:
* __Counter Clerk:__ Registers arriving bikes, records initial photos, and checks repair statuses for customers at the front desk.
* __Mechanic:__ Diagnoses bikes, adds specific repair services to the ticket, and updates the bike's status to "ready".
* __Shop Owner:__ Monitors delayed/overdue repairs and updates the master list of standard services and prices.
* __Customer:__ An external user who accesses the public website to view the list of standard services and current prices.

## Project Documentation
All the technical documents, models, and diagrams for this project are located in the `docs/` folder. Click the links below to navigate through the requirements:

* [User Stories](docs/user-stories.md) - Contains the justifying user stories and acceptance criteria.
* [Domain Model](docs/domain-model.md) - Contains the ER diagram, DBML code, lifecycle, entity history, and design decisions.
* [Decisions](docs/decisions.md) - Contains questions for the shop owner, assumptions, and how they change the model.
* [Wireframes](docs/wireframes.md) - Contains the low-fidelity screen sketches and the system navigation graph.

