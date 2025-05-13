Feature: Daily Sales

Scenario: Happy path
  Given the platform
  When the operator get access the endpoint: /v1/platform/sales/today
  Then the api return 200 and return the following data structure:
    """json
    [
      {
        "saleId": "S78901",
        "timestamp": "2024-05-21T10:35:15Z",
        "totalAmount": 125.50,
        "currency": "USD",
        "itemCount": 2,
        "items": [
          {"productId": "P001-A", "productName": "Wireless Mouse", "quantity": 1, "unitPrice": 25.75, "lineTotal": 25.75},
          {"productId": "P002-B", "productName": "Mechanical Keyboard", "quantity": 1, "unitPrice": 99.75, "lineTotal": 99.75}
        ],
        "customer": {
          "customerId": "CUST0042",
          "type": "registered"
        }
      },
      {
        "saleId": "S78902",
        "timestamp": "2024-05-21T11:15:30Z",
        "totalAmount": 49.99,
        "currency": "USD",
        "itemCount": 1,
        "items": [
          {"productId": "P003-C", "productName": "USB-C Hub", "quantity": 1, "unitPrice": 49.99, "lineTotal": 49.99}
        ],
        "customer": {
          "type": "guest"
        }
      }
    ]
    """

Scenario: No sales recorded for the day
  Given the platform has had no sales transactions today
  When the operator accesses the endpoint: /v1/platform/sales/today
  Then the API returns 200 OK and an empty list `[]`
    """json
    []
    """

Scenario: API internal error
  Given the sales API is experiencing an internal server error
  When the operator accesses the endpoint: /v1/platform/sales/today
  Then the API returns a 500 Internal Server Error status and no content 