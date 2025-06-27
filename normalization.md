# Normalized Database Design

The database design diagram has been normalized to ensure the database is in the third normal form (3NF):
![Normalized-Database-Design diagram](/images/airbnb_database_Normalisation.png)

### Violation of 1NF

**Property Table:** The location column holds multiple values in a single field (street, city, state, etc.). 1NF requires atomicity — each field should store a single, indivisible piece of information.

---

### Break into Multiple Columns

| Property                      |
| ----------------------------- |
| CREATE TABLE Property (       |
| property_id uuid PRIMARY KEY, |
| host_id uuid FOREIGN KEY,     |
| name varchar(255),            |
| description text,             |
| street_name varchar(255),     |
| city varchar(100),            |
| state varchar(100),           |
| country varchar(100),         |
| zip_code varchar(20),         |
| pricepernight decimal(12,2),  |
| created_at timestamp,         |
| updated_at timestamp          |
| );                            |

- Each part of the address is atomic
- Fully complies with 1NF
- Easier to filter/search by city, country, etc.

### Others

The Database also reflect the 2NF and 3NF normalization principles.
