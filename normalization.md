# Normalization of Database Design

## Objective

The objective of this task is to apply normalization principles to ensure that the database design achieves Third Normal Form (3NF). This process involves reviewing the database schema, identifying any potential redundancies or violations of normalization principles, and making necessary adjustments.

## Normalization Steps

### Step 1: Review Current Schema

The current schema consists of the following entities with their attributes:

1. **User**
      - `user_id`
      - `first_name`
      - `last_name`
      - `email`
      - `password_hash`
      - `phone_number`
      - `role`
      - `created_at`

2. **Property**
      - `property_id`
      - `host_id`
      - `name`
      - `description`
      - `location`
      - `price_per_night`
      - `created_at`
      - `updated_at`

3. **Booking**
      - `booking_id`
      - `property_id`
      - `user_id`
      - `start_date`
      - `end_date`
      - `total_price`
      - `status`
      - `created_at`

4. **Payment**
      - `payment_id`
      - `booking_id`
      - `amount`
      - `payment_date`
      - `payment_method`

5. **Review**
      - `review_id`
      - `property_id`
      - `user_id`
      - `rating`
      - `comment`
      - `created_at`

6. **Message**
      - `message_id`
      - `sender_id`
      - `recipient_id`
      - `message_body`
      - `sent_at`

### Step 2: Identify Redundancies

#### First Normal Form (1NF)
    - Each table must have atomic values, and each record must be unique.
    - The current schema meets 1NF requirements since all attributes are atomic and uniquely identifiable through primary keys.

#### Second Normal Form (2NF)
    - All non-key attributes must be fully functionally dependent on the primary key.
    - The current schema also meets 2NF because:
      - All non-key attributes in each table are dependent on the primary key.

#### Third Normal Form (3NF)
    - No transitive dependencies should exist, meaning that non-key attributes must not depend on other non-key attributes.
    - In reviewing the schema, we find:
      - The **Payment** entity can be analyzed for transitive dependencies. The `payment_method` can be defined in a separate table if there are multiple payment methods that need to be referenced.
      - The **User** and **Property** tables do not have any transitive dependencies in the current structure.

### Step 3: Adjust Database Design

To achieve 3NF, the following changes can be made:

1. **Create a Payment_Method Table**:
      - This new table will store details about the different payment methods, ensuring that any changes to payment methods are managed in one place.

### sql
    CREATE TABLE Payment_Method (
       payment_method_id UUID PRIMARY KEY,
       method_name ENUM('credit_card', 'paypal', 'stripe') UNIQUE NOT NULL
    );

### Modify the Payment Table:
    - Replace payment_method with a foreign key reference to the new Payment_Method table.
  
### sql
    Payment {
       UUID payment_id PK
       UUID booking_id FK
       DECIMAL amount NOT NULL
       TIMESTAMP payment_date DEFAULT CURRENT_TIMESTAMP
       UUID payment_method_id FK "Foreign Key references Payment_Method(payment_method_id)"
   }
