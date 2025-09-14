# Entity-Relationship Diagram (ERD) Requirements

## Overview

As part of the ALX Airbnb Database Module, this task requires you to create an Entity-Relationship Diagram (ERD) that represents the database structure for an Airbnb-like application. The ERD should visualize the entities, their attributes, and the relationships between them.

## Learning Objectives
    - Identify entities and their attributes.
    - Define relationships between entities.
    - Create a visual representation of the ERD.

## Requirements

### Entities and Attributes

1. **User**
      - `user_id` (Primary Key, UUID, Indexed)
      - `first_name` (VARCHAR, NOT NULL)
      - `last_name` (VARCHAR, NOT NULL)
      - `email` (VARCHAR, UNIQUE, NOT NULL)
      - `password_hash` (VARCHAR, NOT NULL)
      - `phone_number` (VARCHAR, NULL)
      - `role` (ENUM, (guest, host, admin), NOT NULL)
      - `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

2. **Property**
      - `property_id` (Primary Key, UUID, Indexed)
      - `host_id` (Foreign Key, references User(user_id))
      - `name` (VARCHAR, NOT NULL)
      - `description` (TEXT, NOT NULL)
      - `location` (VARCHAR, NOT NULL)
      - `price_per_night` (DECIMAL, NOT NULL)
      - `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
      - `updated_at` (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

3. **Booking**
      - `booking_id` (Primary Key, UUID, Indexed)
      - `property_id` (Foreign Key, references Property(property_id))
      - `user_id` (Foreign Key, references User(user_id))
      - `start_date` (DATE, NOT NULL)
      - `end_date` (DATE, NOT NULL)
      - `total_price` (DECIMAL, NOT NULL)
      - `status` (ENUM, (pending, confirmed, canceled), NOT NULL)
      - `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

4. **Payment**
      - `payment_id` (Primary Key, UUID, Indexed)
      - `booking_id` (Foreign Key, references Booking(booking_id))
      - `amount` (DECIMAL, NOT NULL)
      - `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
      - `payment_method` (ENUM, (credit_card, paypal, stripe), NOT NULL)

5. **Review**
      - `review_id` (Primary Key, UUID, Indexed)
      - `property_id` (Foreign Key, references Property(property_id))
      - `user_id` (Foreign Key, references User(user_id))
      - `rating` (INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL)
      - `comment` (TEXT, NOT NULL)
      - `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

6. **Message**
      - `message_id` (Primary Key, UUID, Indexed)
      - `sender_id` (Foreign Key, references User(user_id))
      - `recipient_id` (Foreign Key, references User(user_id))
      - `message_body` (TEXT, NOT NULL)
      - `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Relationships
    - **User to Property**: One-to-Many
    - **User to Booking**: One-to-Many
    - **Property to Booking**: One-to-Many
    - **Booking to Payment**: One-to-One
    - **User to Review**: One-to-Many
    - **Property to Review**: One-to-Many
    - **User to Message**: One-to-Many

## ER Diagram


## Mermaid ER Diagram Code

mermaid
erDiagram
    User {
        UUID user_id PK "Primary Key"
        VARCHAR first_name "NOT NULL"
        VARCHAR last_name "NOT NULL"
        VARCHAR email "UNIQUE, NOT NULL"
        VARCHAR password_hash "NOT NULL"
        VARCHAR phone_number "NULL"
        ENUM role "ENUM (guest, host, admin), NOT NULL"
        TIMESTAMP created_at "DEFAULT CURRENT_TIMESTAMP"
    }

    Property {
        UUID property_id PK "Primary Key"
        UUID host_id FK "Foreign Key references User(user_id)"
        VARCHAR name "NOT NULL"
        TEXT description "NOT NULL"
        VARCHAR location "NOT NULL"
        DECIMAL price_per_night "NOT NULL"
        TIMESTAMP created_at "DEFAULT CURRENT_TIMESTAMP"
        TIMESTAMP updated_at "ON UPDATE CURRENT_TIMESTAMP"
    }

    Booking {
        UUID booking_id PK "Primary Key"
        UUID property_id FK "Foreign Key references Property(property_id)"
        UUID user_id FK "Foreign Key references User(user_id)"
        DATE start_date "NOT NULL"
        DATE end_date "NOT NULL"
        DECIMAL total_price "NOT NULL"
        ENUM status "ENUM (pending, confirmed, canceled), NOT NULL"
        TIMESTAMP created_at "DEFAULT CURRENT_TIMESTAMP"
    }

    Payment {
        UUID payment_id PK "Primary Key"
        UUID booking_id FK "Foreign Key references Booking(booking_id)"
        DECIMAL amount "NOT NULL"
        TIMESTAMP payment_date "DEFAULT CURRENT_TIMESTAMP"
        ENUM payment_method "ENUM (credit_card, paypal, stripe), NOT NULL"
    }

    Review {
        UUID review_id PK "Primary Key"
        UUID property_id FK "Foreign Key references Property(property_id)"
        UUID user_id FK "Foreign Key references User(user_id)"
        INTEGER rating "CHECK: rating >= 1 AND rating <= 5, NOT NULL"
        TEXT comment "NOT NULL"
        TIMESTAMP created_at "DEFAULT CURRENT_TIMESTAMP"
    }

    Message {
        UUID message_id PK "Primary Key"
        UUID sender_id FK "Foreign Key references User(user_id)"
        UUID recipient_id FK "Foreign Key references User(user_id)"
        TEXT message_body "NOT NULL"
        TIMESTAMP sent_at "DEFAULT CURRENT_TIMESTAMP"
    }

    %% Relationships
    User ||--o{ Property : hosts
    User ||--o{ Booking : makes
    Property ||--o{ Booking : has
    Booking ||--|| Payment : is
    User ||--o{ Review : submits
    Property ||--o{ Review : has
    User ||--o{ Message : sends
    User ||--o{ Message : receives
