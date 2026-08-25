# User Stories

**[TOO BIG / SPLIT]**
As a mechanic, I want to manage the entire repair process of a bike from the moment it arrives until it leaves the shop, so that the customer is always informed.

1. As a counter clerk, I want to record a bike's arrival with its details, tag number, and initial photos, so that we have an accurate digital record of what entered the shop.
2. As a mechanic, I want to write a detailed diagnostic description for a bike, so that we clearly document what needs to be fixed instead of relying on a short tag note.
3. As a counter clerk, I want to log whether the customer approved or rejected the repair estimate, so that we know if we are authorized to start working.

---
4. As a mechanic, I want to know which fixes have been done to a bike in the past, so that I have a historical log of them.
5. As a counter clerk, I want to know the time limit of the fix, so that the customers don't have to remind me.
6. As a counter clerk, I want to know if a customer is a regular, so that a discount can be applied.
7. As a mechanic, I want to add specific standard jobs (e.g., wheel true, brake bleed) to a bike's repair ticket, so that the total cost is accurately calculated from our standard list.
8. As a mechanic, I want to change a bike's status to "ready", so that the counter clerk knows the job is done without having to walk to the back of the workshop.
9. As a shop owner, I want to update the master list of repair jobs and prices, so that the shop charges the correct new rates when January comes.
10. As a customer, I want to view the list of standard services and repair prices online, so that I can decide if I want to bring my bike in without having to call the shop.
11. As a shop owner, I want to see a list of repairs that have passed their promised date, so that I can identify delayed bikes before the customer calls to complain.
12. As a counter clerk, I want to search for an active repair by the customer's name or phone number, so that I can instantly tell them the status of their bike when they call.

# Criteria for the Stories

_As a customer, I want to view the list of standard services and repair prices online, so that I can decide if I want to bring my bike in without having to call the shop._

1. Every service on the website is shown with its name and current price.
2. The public services list is sorted lower to higher price.
3. If there's no input to the system from the shop, the website shows an error message instead of a blank table.

_As a counter clerk, I want to know if a customer is a regular, so that a discount can be applied._

1. The screen shows how many times the customer has visited and how many fixes they have requested.
2. The screen visually indicates if the customer qualifies for a regular discount.
3. The final price on the screen is updated to reflect the applied discount.

_As a shop owner, I want to see a list of repairs that have passed their promised date, so that I can identify delayed bikes before the customer calls to complain_

1. he list only displays repairs where the promised date is in the past and the bike is not yet ready.
2. Each row on the list shows the bike's log and its current repair status.
3. Overdue repairs are visually highlighted on the screen so the owner knows exactly who to call.

_As a counter clerk, I want to search for an active repair by the customer's name or phone number, so that I can instantly tell them the status of their bike when they call_

1. The screen displays a search bar that accepts both names and phone numbers.
2. The search results correctly show the matching clients.
3. The current status of the repair is clearly visible in the search results list.