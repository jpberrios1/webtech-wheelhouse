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

---
## Dependencies 

* __Ruby:__ 4.0.4
* __Rails:__ 8.0
* __Node.js:__ 26.1.0
* __PostgresSQL:__ 18.6
* __WSL:__ 2.6.3.0
* __Yarn:__ 1.22.22

*Note: For a step-by-step guide to installing the dependencies [visit this link](https://brainy-barometer-470.notion.site/Install-Ruby-on-Rails-on-Windows-62a5e4ec60bb4697add5b3dd0fd56dac)*

## Setup Instructions
Run the following commands in order to configure the project locally.

*(Note: There are no models or migrations yet. The database is simply created to satisfy the PostgreSQL adapter requirement)*

1. Install required Ruby gems:
```
    bundle install
```

2. Install the Node packages and dependencies required for frontend bundling:
```
yarn install
```

3. Create the development and test databases:
```
bin/rails db:create
```

## Starting the Application
To run the application, you must use the development script. This ensures the local Sass compiler processes the custom Bootstrap stylesheets in real-time alongside the Rails server.

Start the application by running:
```
bin/dev
```
Once the processes boot up successfully, open your browser and visit `http://localhost:3000`




