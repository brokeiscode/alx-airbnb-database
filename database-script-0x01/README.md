# Airbnb Database Schema - SQL Definition

This directory provides the SQL schema definition for a Airbnb-clone project, designed for **PostgreSQL** database.

---

## Contents

- `schema.sql`  
  Full database schema for PostgreSQL, including:

  - Table creation with primary keys, foreign keys, constraints
  - ENUM type definitions for controlled fields like `role`, `status`, and `payment_method`

---

## 🗄️ Database Structure

### Tables:

✅ `User` — Stores platform users with roles:

- `guest`, `host`, `admin`

✅ `Property` — Listings managed by hosts, includes address details

✅ `Booking` — Reservation records with:

- Status: `pending`, `confirmed`, `canceled`

✅ `Payment` — Payment information with:

- Method: `credit_card`, `paypal`, `stripe`

✅ `Message` — Direct messages exchanged between hosts and users

✅ `Review` — Guest feedback with 1 to 5-star ratings

---

## 🛠️ Technical Notes

### For PostgreSQL:

- Requires version 13+
- Uses `UUID` for primary keys
- ENUM types defined with `CREATE TYPE` for:
  - `user_role`
  - `booking_status`
  - `payment_method_type`

---

## ⚡ Getting Started

1. Execute the appropriate schema file for your database:

**PostgreSQL:**

```bash
psql -d your_database -f schema.sql
```
