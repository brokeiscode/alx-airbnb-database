# Airbnb Database SQL Scripts

This directory contain SQL script for simulating an Airbnb-clone database for **PostgreSQL** environment, including randomised sample data for population.

---

## Contents

- `seed.sql`

  - Bulk randomised inserts for PostgreSQL
  - Uses `gen_random_uuid()` and `generate_series()` for realistic test data
  - Requires the `pgcrypto` extension for UUID generation

---

## 🗄️ Database Tables Included

- `User` — Stores user profiles with roles (`guest`, `host`, `admin`)
- `Property` — Listings with address details and price per night
- `Booking` — Reservation records with status tracking (`pending`, `confirmed`, `canceled`)
- `Payment` — Payment transactions with different methods (`credit_card`, `paypal`, `stripe`)
- `Message` — Messages exchanged between users
- `Review` — Reviews and ratings left by guests

---

## 🛠️ Prerequisites

### For PostgreSQL:

- PostgreSQL 13 or higher
- Enable `pgcrypto` extension for UUIDs:
  ```sql
  CREATE EXTENSION IF NOT EXISTS pgcrypto;
  ```
