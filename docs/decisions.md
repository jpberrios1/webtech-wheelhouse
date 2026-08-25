# Questions

1. Would you like to send an email to the customers to notify them if the bike is ready?
2. Would you like to know if a discount is applied if the fix is too short?
3. Would you like to send the paragraph that describes what was fixed via email or on the website instead of just being told at the counter?

# Assumptions

1. The assumption is they keep working via phone to contact the user if their bike is ready.
2. There's no saved data related to this.
3. There's no digital need to deliver this, it is delivered to the customer verbally or printed on paper at checkout.

# Changes

1. The database doesn't need to save the phone, instead it saves the mail from the customer to notify them when it is ready.
2. In the RepairServices table a discount_reason column is added.
3. If it needs to be delivered digitally and tracked, it would add a diagnostic_sent_at (timestamp) column to the Repairs table to record exactly when the customer received the information.