## Database Schema Overview

### customers
Stores customer demographic information.

Primary Key:
- customer_id

### orders
Stores order-level transaction details.

Primary Key:
- order_id

Foreign Key:
- customer_id → customers.customer_id

### order_items
Stores product-level details for each order.

Primary Key:
- (order_id, order_item_id)

Foreign Keys:
- order_id → orders.order_id
- product_id → products.product_id

### products
Stores product catalog information.

Primary Key:
- product_id

### payments
Stores payment transactions for each order.

Foreign Key:
- order_id → orders.order_id