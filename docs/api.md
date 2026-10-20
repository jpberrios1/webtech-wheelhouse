# Wheelhouse API Documentation

## Routes

| Verb   | Path                      | Requires Token? | Statuses             | Description                                  |
| ------ | ------------------------- | --------------- | -------------------- | -------------------------------------------- |
| `GET`  | `/api/v1/services`        | No              | 200                  | Returns a list of all services.              |
| `GET`  | `/api/v1/services/:id`    | No              | 200, 404             | Returns a single service by its ID.          |
| `POST` | `/api/v1/services`        | Yes             | 201, 400, 401, 422   | Creates a new service.                       |
| `GET`  | `/api/v1/repairs`         | Yes             | 200, 400, 401        | Returns all repairs (filtered by `?state=`). |
| `GET`  | `/api/v1/repairs/:id`     | Yes             | 200, 401, 404        | Returns a single repair by its ID.           |

## Design Decisions

1. **How a price travels:** Prices travel as `String` format instead of numeric floats to prevent precision loss (floating-point math errors) in client applications that parse the JSON, ensuring the exact billed amount is preserved.
2. **What the document of a repair leaves out and why:** The repair document explicitly leaves out the `customer.phone_number` and the `mechanic` relationships. The accounting program only needs financial data (totals, lines) and basic identifiers (bike serial, customer name) to reconcile invoices; exposing personal contact data or employee assignments violates the principle of least privilege.

## JSON Document Shapes

### Error Shape (400, 401, 404, 422)
```json
{
  "errors": [
    "Invalid or missing token"
  ]
}
```

## Single Service
```json
{
  "id": 1,
  "name": "Basic Tune-up",
  "price": "65.0",
  "charged_on_repairs_count": 12
}
```

## Single Repair
```json
{
  "id": 5,
  "state": "ready",
  "came_in_on": "2026-10-15",
  "promised_on": "2026-10-18",
  "handed_back_at": null,
  "total": "85.0",
  "overdue": false,
  "customer_answer": "approved",
  "bike": {
    "brand": "Trek",
    "model": "Marlin 7",
    "serial_number": "WTU123456"
  },
  "customer": {
    "name": "John Doe"
  },
  "lines": [
    {
      "service": "Basic Tune-up",
      "charged_price": "65.0"
    },
    {
      "service": "Chain Lubrication",
      "charged_price": "20.0"
    }
  ]
}
```