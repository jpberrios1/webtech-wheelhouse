# Wheelhouse Bike Shop

## What is Wheelhouse?
Wheelhouse is a local bike repair shop. This project proposes a new system design and domain model to digitize their workflow. The system aims to manage active repairs, track specific physical bikes (using serial numbers) to prevent mix-ups, and maintain a standardized public price list to ensure consistent billing.

## Who uses it?
The system is designed to be used by four distinct roles:
* __Counter Clerk:__ Registers arriving bikes and checks repair statuses for customers at the front desk.
* __Mechanic:__ Adds specific repair services to the ticket, and updates the bike's status to "ready".
* __Shop Owner:__ Monitors delayed/overdue repairs and updates the master list of standard services and prices.
* __Customer:__ An external user who accesses the public website to view the list of standard services and current prices.

## Project Documentation
All the technical documents, models, and diagrams for this project are located in the `docs/` folder. Click the links below to navigate through the requirements:

* [User Stories](docs/user-stories.md) - Contains the justifying user stories and acceptance criteria.
* [Domain Model](docs/domain-model.md) - Contains the ER diagram, DBML code, lifecycle, entity history, and design decisions.
* [Decisions](docs/decisions.md) - Contains questions for the shop owner, assumptions, and how they change the model.
* [Wireframes](docs/wireframes.md) - Contains the low-fidelity screen sketches and the system navigation graph.
* [API Documentation](docs/api.md) - Contains the available routes, JSON document shapes, and backend design decisions.

## Prerequisites
* The project must run in a Linux environment.

* PostgreSQL with a role matching your system's username with permissions to create databases

* `libvips` is required by Active Storage and the `image_processing` gem to process image variants and generate thumbnails.

Follow these steps to install it:

__macOS (Homebrew)__
```
brew install vips
```

__Ubuntu / Debian__
```
sudo apt install libvips
```


## Dependencies 

* __Ruby:__ 4.0.4
* __Rails:__ 8.0
* __Node.js:__ 26.1.0
* __PostgreSQL:__ 18.6
* __Yarn:__ 1.22.22

*Note: For a step-by-step guide to installing the dependencies [visit this link](https://brainy-barometer-470.notion.site/Install-Ruby-on-Rails-on-Windows-62a5e4ec60bb4697add5b3dd0fd56dac)*

## Setup Instructions
Run the following commands in order to configure the project locally.

1. Clone the repository and navigate into the project directory:
```
git clone https://github.com/jpberrios1/webtech-wheelhouse.git
cd webtech-wheelhouse
```

2. Install required Ruby gems:
```
bundle install
```

3. Install the Node packages and dependencies required for frontend bundling:
```
yarn install
```

4. Reset, migrate, and seed the database. This will delete any existing local database data.

```
bin/rails db:reset
```

5. Build the CSS (Crucial to compile Boostrap for the first time)
```
yarn build:css
```
## Starting the Application
To run the application, you must use the development script. This ensures the local Sass compiler processes the custom Bootstrap stylesheets in real-time alongside the Rails server.

__IMPORTANT NOTE:__ Do NOT use the standard `rails server` or `bin/rails s` commands, otherwise the page will load without styling

Start the application by running:
```
bin/dev
```
Once the processes boot up successfully, open your browser and visit `http://localhost:3000/` to see the website. 

## API Documentation
This project provides a RESTful JSON API under the `/api/v1` namespace, with optimized endpoints and CORS configuration to enable secure integration with [this website](https://jpberrios1.github.io/webtech-lab-01/).

### API Token Configuration (Required for Testing)
All endpoints (except `GET /api/v1/services`) are protected and require a Bearer token. Since Rails credentials are encrypted by default, is necessary to set up a local token to test the API creations:

1. Open the encrypted credentials file in your terminal.
```
EDITOR="code" bin/rails credentials:edit
```
_Note: If you are using other editor, change code for the editor of your preference_

2. Add the following line at the bottom of the file with your desired token.
```
api_token: "your_secret_token_here"
```
3. Save and exit.
 
4. Include this token in your API requests using the following header:
`Authorization: Bearer your_secret_token_here`

## CORS Rules
CORS is strictly configured to only allow requests from specific origins (`https://jpberrios1.github.io`). If you are testing the frontend integration (from the repository granted) locally alongside this Rails server:

* __DO NOT open the `index.html` directly from the file explorer.__ Modern browsers will block the `fetch` request with a CORS `null` origin error (protocol `file:///`)
* __USE A LOCAL SERVER:__ Please serve the HTML file using a tool like VS Code Live Server
* __USE PORT 5500:__ The CORS configuration explicitly allows `http://127.0.0.1:5500` and `http://localhost:5500`. If your local server uses a different port, the Rails API will reject the connection.

### Available Endpoints
* `GET /api/v1/services` - Returns a list of all available repair services and their prices (Public).
* `POST /api/v1/services` - Creates a new repair service (Requires Token)
* `GET /api/v1/repairs` - Returns all repairs (Requires Token). Accepts an optional `?state=` query parameter to filter results.
* `GET /api/v1/repairs/:id` - Returns detailed information about a specific repair (Requires Token).

### Terminal Examples (CURL)
You can test the API directly from your terminal.

1. __Reading the public price list (No Token required)__
```
curl -X GET http://localhost:3000/api/v1/services -H "Accept: application/json"
```

2. __Creating a new service (Requires Token)__
```
curl -X POST http://localhost:3000/api/v1/services \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your_secret_token_here" \
  -d '{"service": {"name": "Test Service", "current_price": 50}}'
```